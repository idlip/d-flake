{ pkgs, inputs, callPackage, config, ... }:

let
in
{
  home.file.".config/emacs/early-init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.__D_NIX__/modules/home/emacs/.configs/early-init.el";
  home.file.".config/emacs/init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.__D_NIX__/modules/home/emacs/.configs/init.el";
    home.file.".config/emacs/elfeed.org".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.__D_NIX__/modules/home/emacs/.configs/elfeed.org";
  
  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtk;
    extraPackages = (epkgs: (with epkgs; [
    	vterm
	    undo-tree
	    flycheck
      no-littering  vertico-posframe rainbow-delimiters rainbow-mode vertico 
      orderless consult marginalia embark embark-consult org olivetti org-modern corfu cape
      markdown-mode nix-mode
      all-the-icons-dired async dired-hide-dotfiles dired-single 
      reddigg mingus pdf-tools vterm which-key
      org-mime catppuccin-theme corfu-terminal
      sdcv elfeed elfeed-org link-hint general powerthesaurus
      doom-modeline org-auto-tangle 
      ])
    );
  };
}
