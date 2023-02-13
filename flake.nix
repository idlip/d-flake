{
  description = "D Nixified Flaky Station";
  # https://dotfiles.sioodmy.dev

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/nur";
      hyprland = {  
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };

    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";

      emacs-overlay = {                                                     # Emacs Overlays
        url = "github:nix-community/emacs-overlay";
      };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = inputs @ {self, hyprland, nur, home-manager, nixpkgs, ...} : let
    system = "x86_64-linux";
    user = "i";
    location = "$HOME/.setup";
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in {
    nixosConfigurations = import ./hosts inputs;


    # nixosConfigurations = (  
    #     import ./hosts inputs {     
    #       inherit (nixpkgs) lib;
    #       inherit inputs nixpkgs home-manager  user location  hyprland; 
    #     }
    #   );


  };
}
