{pkgs, lib, config, ...}: {
  home.packages = [pkgs.wofi];
  # xdg.configFile."wofi".source = ./configs/.;

  home.file.".config/wofi".recursive = true;
  home.file.".config/wofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.__D_NIX__/modules/home/wofi/.configs";
}

