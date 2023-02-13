{
  nixpkgs,
  self,
  ...
}: let
  inputs = self.inputs;
  bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  wayland = ../modules/wayland;
  # server = ../modules/server;
  hw = inputs.nixos-hardware.nixosModules;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [core ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.i = ../modules/home;
  };
in {
  # all my hosts are named after saturn moons btw

  # desktop
  gdk = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "gdk";}
        ./gdk/hardware-configuration.nix
        bootloader
        wayland
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };


}
