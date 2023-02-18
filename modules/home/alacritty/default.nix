
{ pkgs, config, self, lib, ... }:

{
  home.file.".config/alacritty/catppuccin.yml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.__D_NIX__/modules/home/alacritty/catppuccin.yml";
  
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = rec {
          normal.family = "ComicCodeLigatures";
          bold = { family = "Fira Code Nerd Font"; style = "Bold"; };
          size = 18;
        };
        offset = {                            # Positioning
          x = -1;
          y = 0;
        };
        env = {
          TERM = "xterm-256color";
        };
      };
    };
  };
}
