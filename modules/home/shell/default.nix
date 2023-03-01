{
  config,
  lib,
  pkgs,
  ...
}: let
  apply-hm-env = pkgs.writeShellScript "apply-hm-env" ''
    ${lib.optionalString (config.home.sessionPath != []) ''
      export PATH="${builtins.concatStringsSep ":" config.home.sessionPath}:/home/i/.local/bin/d/:$PATH"
    ''}
    ${builtins.concatStringsSep "\n" (lib.mapAttrsToList (k: v: ''
        export ${k}=${v}
      '')
      config.home.sessionVariables)}
    ${config.home.sessionVariablesExtra}
    exec "$@"
  '';

in {
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
  programs = {
    exa.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        scan_timeout = 5;
        character = {
          error_symbol = " [](#df5b61)";
          success_symbol = "[](#6791c9)";
          vicmd_symbol = "[](bold yellow)";
	        format = "[   $directory$all$character  ](bold)";
        };
        git_commit = {commit_hash_length = 4;};
        line_break.disabled = false;
        lua.symbol = "[](blue) ";
        python.symbol = "[](blue) ";
	      directory.read_only = " ";
	nix_shell.symbol = " ";
        hostname = {
          ssh_only = true;
          format = "[$hostname](bold blue) ";
          disabled = false;
        };
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      dotDir = ".config/shell";
      sessionVariables = {
        LC_ALL = "en_US.UTF-8";
        ZSH_AUTOSUGGEST_USE_ASYNC = "true";
        SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      };
      completionInit = ''
	eval "$(starship init zsh)"
	
	autoload -U colors && colors	# Load colors
	setopt autocd		# Automatically cd into typed directory.
	stty stop undef		# Disable ctrl-s to freeze terminal.
	setopt interactive_comments
	
	export PATH="$PATH:$HOME/.local/bin/d"
	export STARDICT_DATA_DIR="$HOME/.local/share/stardict"
	
	# Basic auto/tab complete:
	autoload -U compinit
	zstyle ':completion:*' menu select
	zmodload zsh/complist
	compinit
	_comp_options+=(globdots)		# Include hidden files.
	
	
	# Use vim keys in tab complete menu:
	bindkey -M menuselect 'h' vi-backward-char
	bindkey -M menuselect 'k' vi-up-line-or-history
	bindkey -M menuselect 'l' vi-forward-char
	bindkey -M menuselect 'j' vi-down-line-or-history
	bindkey -v '^?' backward-delete-char
	
	bindkey -e

      '';
      envExtra = ''
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	export PATH="$PATH:$HOME/.local/bin/d"
  export EDITOR="emacsclient -nw -a 'nvim'"
  export VISUAL=$EDITOR
  export GRIM_DEFAULT_DIR="/home/i/pics/sshots/"

      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland
      fi

      '';
      initExtra = ''

        function ytdl() {
            yt-dlp --embed-metadata --embed-subs -f 22 "$1"
        }

        function run() {
          nix run nixpkgs#$@
        }

        command_not_found_handler() {
          printf 'Command not found ->\033[01;32m %s\033[0m \n' "$0" >&2
          return 127
        }

        clear
      '';
      history = {
        save = 1000;
        size = 1000;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
      };

      dirHashes = {
        docs = "$HOME/docs";
        notes = "$HOME/docs/notes";
        dotfiles = "$HOME/dotfiles";
        dl = "$HOME/dloads";
        vids = "$HOME/vids";
        music = "$HOME/music";
        media = "/run/media/$USER";
      };

      shellAliases = let
        # for setting up license in new projects

      in
        with pkgs; {
          rebuild = "doas nix-store --verify; pushd ~dotfiles && doas nixos-rebuild switch --flake .# && notify-send \"Done\"&& bat cache --build; popd";
          cleanup = "doas nix-collect-garbage --delete-older-than 7d";
          bloat = "nix path-info -Sh /run/current-system";
          ytmp3 = ''
            ${lib.getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';
          cat = "${lib.getExe bat} --style=plain";
          grep = lib.getExe ripgrep;
          du = lib.getExe du-dust;
          ps = lib.getExe procs;
          m = "mkdir -p";
          fcd = "cd $(find -type d | fzf)";
          ls = "${lib.getExe exa} -h --git --icons --color=auto --group-directories-first -s extension";
          l = "ls -lF --time-style=long-iso --icons";
          la = "${lib.getExe exa} -lah --tree";
          tree = "${lib.getExe exa} --tree --icons --tree";
          http = "${lib.getExe python3} -m http.server";
          burn = "pkill -9";
          diff = "diff --color=auto";
          kys = "doas shutdown now";
          killall = "pkill";
          ".1" = "cd ..";
          ".2" = "cd ../..";
          ".3" = "cd ../../..";
          c = "clear";
          # helix > nvim
          v = "nvim";
          emd = "pkill emacs; emacs --daemon";
          ytdl = "yt-dlp -f 22";
          e = "emacsclient -t";
          cp="cp -iv";
	        mv="mv -iv";
	        rm="rm -vI";
	        bc="bc -ql";
	        mkd="mkdir -pv";
          ytfzf="ytfzf -Df";
          hyprcaps="hyprctl keyword input:kb_options caps:caps";
          gc = "git clone --depth=1";
          sudo = "doas";
        };

      plugins = with pkgs; [
        {
          name = "zsh-nix-shell";
          src = zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }

        {
          name = "zsh-autopair";
          file = "zsh-autopair.plugin.zsh";
          src = fetchFromGitHub {
            owner = "hlissner";
            repo = "zsh-autopair";
            rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
            sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
          };
        }
      ];
    };
  };
}
