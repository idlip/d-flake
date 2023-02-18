{
  config,
  pkgs,
  ...
}: {
  
  services = {
    tlp.enable = true;                      # TLP and auto-cpufreq for power management
    logind = {
      lidSwitch = "suspend";
      extraConfig = ''
    HandlePowerKey = suspend
    '';
    };
    auto-cpufreq.enable = true;
    # blueman.enable = true;
  };


  services = {

    gvfs.enable = true;
    syncthing = {
      enable = true;
      user = "i";
      configDir = "/home/i/.config/syncthing";
      overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI
    devices = {
      "realme" = { id = "JAJECCB-UC73TPE-KJFHYK4-KZT2A74-BEQSYVG-LAKP34N-V2G5E6X-TH2ZQQQ"; };
      #"device2" = { id = "DEVICE-ID-GOES-HERE"; };
    };
    folders = {
      "music-jazz" = {        # Name of folder in Syncthing, also the folder ID
        path = "/home/i/music";    # Which folder to add to Syncthing
        devices = [ "realme" ];      # Which devices to share the folder with
      };
      "syncs" = {
        path = "/home/i/sync";
        devices = [ "realme" ];
        ignorePerms = false; 
      };
    };
  };

    # udisks2.enable = true;
    fstrim.enable = true;
    getty.autologinUser = "i" ;
    atd.enable = true;
    # Use pipewire instead of soyaudio
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };


}
