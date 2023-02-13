{
  config,
  pkgs,
  ...
}: {
  services = {
    dbus = {
      packages = with pkgs; [dconf udisks2];
      enable = true;
    };
    
    # udev.packages = with pkgs; [gnome.gnome-settings-daemon];
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
     udisks2.enable = true;
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';
  };

  # compresses half the ram for use as swap
  zramSwap = {
    enable = true;
    memoryPercent = 50 ;
    algorithm = "zstd";
  };

  environment.variables = {
    # EDITOR = "nvim";
    BROWSER = "firefox";
  };
  environment.systemPackages = with pkgs; [
    git
    ntfs3g
    # (writeScriptBin "sudo" ''exec doas "$@"'')
  ];

  time.timeZone = "Asia/Kolkata";

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };  

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.doas.enable = true;
  security.sudo.enable = false;
  # Configure doas
  security.doas.extraRules = [{
  users = [ "i" ];
  keepEnv = true;
  persist = true;  
  }];
}
