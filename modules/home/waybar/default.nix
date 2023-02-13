{
  pkgs,
  lib,
  config,
  ...
}: let

in {
  # xdg.configFile."waybar/style.css".text = import ./style.nix;

  home.file.".config/waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink /home/i/.__D_NIX__/modules/home/waybar/style.css;
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        spacing = 7;
        fixed-center = true;
        exclusive = true;
        modules-left = [
          "custom/launcher"
	        "wlr/workspaces"
          "hyprland/window"
          "hyprland/submap"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = ["network" "memory" "pulseaudio" "custom/power"];
        "wlr/workspaces" = {
          format = "{icon}";
          active-only = false;
          on-click = "activate";
          format-icons = {
          active = "";
          default = "";
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
          };
        };

        "hyprland/window" = {
          "format" = "🧬 {}";
          "separate-outputs" = true;
	};

          "hyprland/submap" = {
            "format" = " {}";
            "max-length" = 14;
	          "tooltip" = false;
	        };

          "custom/launcher" = with pkgs; {
            format = " ";
            tooltip = false;
            on-click = "wofi -S drun";
          };

          "custom/power" = {
            "format" = " ";
            "on-click" = "d-power";
            "tooltip" = false;
          };
          "clock" = {
            "tooltip-format" = "{:%A %B %d %Y | %H:%M}";
            "format-alt" = " {:%a %d %b  %I:%M %p}";
              "format" = " {:%H:%M} ";
            ##"timezones" = [ "Kolkata" ];
            ##"max-length" = 200;
              "interval" = 1;
          };
          "cpu" = {
            "format" = "﬙ {usage: >3}%";
            "on-click" = "alacritty -e htop";
          };
          "memory" = {
            "format" = " {: >3}%";
            "on-click" = "foot -e btop";
          };
          "network" = {
            "interface" = "wlp2s0";
            "format" = "⚠ Disabled";
            "format-wifi" = " {bandwidthDownBytes}  {bandwidthUpBytes}";
            "format-ethernet" = " {ifname}: {ipaddr}/{cidr}";
            "format-disconnected" = "⚠ Disconnected";
            "on-click" = "foot -e nmtui";
            "interval" = 2;
          };
          "pulseaudio" = {
            "scroll-step" = 2;
            "format" = "{icon} {volume: >3}%";
            "format-bluetooth" = "{icon} {volume: >3}%";
            "format-muted" =" muted";
	          "on-click" = "pamixer -t";
            "format-icons" = {
              "headphones" = "";
              "handsfree" = "";
              "headset" = "";
              "phone" = "";
              "portable" = "";
              "car" = "";
              "default" = ["" ""];
            };
          };
      };
    };
  };
}
