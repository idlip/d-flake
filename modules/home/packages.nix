{
  inputs,
  pkgs,
  config,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    cached-nix-shell
    firefox
    pcmanfm libreoffice
    brave librewolf ungoogled-chromium deluged
    yt-dlp
    fzf  ani-cli ytfzf jq
    neovim 
    unzip aspell aspellDicts.en
    ripgrep nitch
    rsync
    alacritty
    ffmpeg sdcv  
    imagemagick
    fd ncdu mu isync ts  syncthing 
    jq keepassxc
    figlet
    keepassxc
    dconf
    gcc
  ];
}
