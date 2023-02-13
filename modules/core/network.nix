{
  config,
  pkgs,
  lib,
  ...
}: {

  networking = {
    # dns
    networkmanager = {
      enable = true;
      unmanaged = ["docker0" "rndis0"];
      wifi.macAddress = "random";
    };
    firewall = {
      enable = true;
      # if your minecraft server is not worky
      # this is probably why
      allowedTCPPorts = [8384 22000];
      allowedUDPPorts = [22000 21027];
      allowPing = false;
      logReversePathDrops = true;
    };
  };
  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
}
