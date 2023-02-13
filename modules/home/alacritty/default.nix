
{ pkgs, config, self, lib, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = rec {                          # Font - Laptop has size manually changed at home.nix
          normal.family = "FiraCode Nerd Font";
          bold = { style = "Bold"; };
          size = 18;
        };
        offset = {                            # Positioning
          x = -1;
          y = 0;
        };
      };
    };
  };
}