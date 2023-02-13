{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };

in {


  
  home.packages = with pkgs; [
    libnotify
    wf-recorder
    brightnessctl
    pamixer
    slurp
    grim
    wl-clipboard
    rofi-wayland
    cliphist
    wtype
    swaybg
    swayidle
    gammastep
  ];


  wayland.windowManager.hyprland = {
    enable = true;
    # extraConfig = builtins.readFile ./hyprland.conf;
  };

    xdg.configFile."hypr/hyprland.conf" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.__D_NIX__/modules/home/hyprland/hyprland.conf"; };

  #systemd.user.services = {
    # swaybg = mkService {
    #   Unit.Description = "Wallpaper chooser";
    #   Service = {
    #     ExecStart = "${lib.getExe pkgs.swaybg} -i ${./wall.png}";
    #     Restart = "always";
    #   };
    # };
  #  cliphist = mkService {
  #    Unit.Description = "Clipboard history";
  #    Service = {
  #      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getExe pkgs.cliphist} store";
  #      Restart = "always";
  #    };
  #  };
  #};
 }

