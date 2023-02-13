{
  self,
  pkgs,
  config,
  inputs,
  ...
}: {
  home.packages = [ pkgs.dconf ];
  gtk = {
    enable = true;
    # theme = {
      # name = "Qogir-Dark";
      # package = pkgs.qogir-theme;
    # };
    theme = {
      name = "Catppuccin-Mocha-Standard-Rosewater-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["rosewater"];
        variant = "mocha";
      };
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
    font = {
      name = "ComicCodeLigatures";
      size = 17;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  # cursor theme
  home.pointerCursor = {
    # package = pkgs.bibata-cursors;
    # name = "Bibata-Modern-Classic";
    package = pkgs.catppuccin-cursors.mochaRosewater;
    name = "Catppuccin-Mocha-Rosewater-Cursors";
    size = 32;
  };
  home.pointerCursor.gtk.enable = true;

}
