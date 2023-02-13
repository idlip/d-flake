{pkgs, lib, config, ...}: {
  home.packages = [pkgs.rofi-wayland];
  #xdg.configFile."rofi".source = ./configs/.;
  
  home.file.".config/rofi".recursive = true;
  home.file.".config/rofi".source = config.lib.file.mkOutOfStoreSymlink /home/i/.__D_NIX__/modules/home/rofi/.configs;
}
