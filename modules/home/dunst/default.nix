{
  config,
  self,
  lib,
  pkgs,
  ...
}: let
  colors = import ../themes/colors.nix;
  volume = let
    pamixer = lib.getExe pkgs.pamixer;
    notify-send = pkgs.libnotify + "/bin/notify-send";
  in
    pkgs.writeShellScriptBin "volume" ''
      #!/bin/sh

      ${pamixer} "$@"

      volume="$(${pamixer} --get-volume-human)"

      if [ "$volume" = "muted" ]; then
          ${notify-send} -r 69 \
              -a "Volume" \
              "Muted" \
              -i ${./mute.svg} \
              -t 888 \
              -u low
      else
          ${notify-send} -r 69 \
              -a "Volume" "Currently at $volume" \
              -h int:value:"$volume" \
              -i ${./volume.svg} \
              -t 888 \
              -u low
      fi
    '';
in {
  home.packages = [volume];
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
    settings = with colors.scheme.doom; {
      global = {
        monitor = 0;
        background = "#${bg}";
        frame_color = "#89AAEB";
        transparency = 0;
        follow = "none";
        width = 900;
        height = 900;
        idle_threshold = 120;
        origin = "top-right";
        offset = "10x50";
        scale = 0;
        notification_limit = 0;
        progress_bar = "true";
        alignment = "center";
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 500;
        indicate_hidden = "yes";
        separator_height = 2;
        padding = 20;
        horizontal_padding = 12;
        text_icon_padding = 8;
        frame_width = 3;
        separator_color = "frame";
        sort = "yes";
        font = "ComicCodeLigatures 20";
        line_height = 0;
        markup = "full";
        stack_duplicates = "true";
        format = "<b>%s</b>\n%b";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        show_indicators = "yes";
        icon_position = "left";
        max_icon_size = 32;
        sticky_history = "yes";
        history_length = 20;
        browser = "/home/i/.local/bin/d/d-stuff";
        always_run_script = "true";
        title = "Dunst";
        class = "Dunst";
        corner_radius = 20;
        ignore_dbusclose = false;
        force_xwayland = "false";
        mouse_left_click = "do_action";
        mouse_middle_click = "do_action";
        mouse_right_click = "close_all";
	};

	reminder = {
 	 category = "reminder";
 	 background = "#33333390";
 	 foreground = "#ffffff";
 	 timeout = 0;
 	 script="d-notif";
      };

      fullscreen_delay_everything.fullscreen = "delay";
      urgency_low = {
        background = "#${bg}";
        foreground = "#${text}";
        timeout = 5;
      };
      urgency_normal = {
        background = "#${bg}";
        foreground = "#${text}";
        timeout = 6;
      };
      urgency_critical = {
        background = "#${bg}";
        foreground = "#${text}";
        frame_color = "#${red}";
        timeout = 0;
      };
    };
  };
}

