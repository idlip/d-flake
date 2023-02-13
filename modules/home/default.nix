{
  inputs,
  pkgs,
  config,
  lib,
  self,
  ...
}:
# glue all configs together
{
  config.home.stateVersion = "22.11";
  config.home.extraOutputsToInstall = ["doc" "devdoc"];
  imports = [
    ./packages.nix

    ./gtk
    # ./git
    ./foot
    ./dunst
    ./bottom
    ./shell
    ./aria2
    ./btop
    ./ytfzf
    ./wofi    
    ./rofi
    ./sioyek
    ./alacritty
    ./firefox
    
    ./emacs
    # ./swaylock
    ./tools
    ./waybar
    ./newsboat
    ./hyprland
    ./media
    #./helix
    # ./schizofox
    inputs.hyprland.homeManagerModules.default
    inputs.nur.nixosModules.nur
  ];

}
