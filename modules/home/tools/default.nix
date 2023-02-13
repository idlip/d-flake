{
  pkgs,
  lib,
  config,
  ...
}: let
  browser = ["firefox.desktop"];

  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = ["imv.desktop"];
    "application/json" = browser;
    "application/pdf" = ["sioyek.desktop"];
    "x-scheme-handler/magnet" = ["d-stuff.desktop"];
    "application/epub+zip" = ["sioyek.desktop"];
    "application/zip" = ["sioyek.desktop"];
    "application/x.bittorrent" = ["d-stuff.desktop"];
  };
in {
  services = {
    # udiskie = {
      # enable = true;
      # automount = true;
    # };
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableSshSupport = true;
      enableZshIntegration = true;
    };
  };
  programs = {
    gpg.enable = true;
    man.enable = true;
  #  direnv = {
  #    enable = true;
  #    nix-direnv.enable = true;
  #  };
  #  tealdeer = {
  #    enable = true;
  #    settings = {
  #      display = {
  #        compact = false;
  #        use_pager = true;
  #      };
  #      updates = {
  #        auto_update = true;
  #      };
  #    };
  #  };
    bat = {
      enable = true;
    };
  };
  xdg = {
    userDirs = {
      enable = true;
      documents = "$HOME/docs";
      download = "$HOME/dloads";
      videos = "$HOME/vids";
      music = "$HOME/music";
      pictures = "$HOME/pics";
      desktop = "$HOME/other";
      publicShare = "$HOME/other";
      templates = "$HOME/other";
    };
    mimeApps.enable = true;
    mimeApps.associations.added = associations;
    mimeApps.defaultApplications = associations;
  };
}
