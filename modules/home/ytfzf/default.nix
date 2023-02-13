{pkgs, lib, config, ...}: {
  home.packages = [pkgs.ytfzf];
  # xdg.configFile."ytfzf".source = ./.;
  home.file.".config/ytfzf/conf.sh".source = config.lib.file.mkOutOfStoreSymlink /home/i/.__D_NIX__/modules/home/ytfzf/conf.sh;
  

}


