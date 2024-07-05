{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
    self.nixosModules.desktop
    ./bakugo/boot.nix
    ./bakugo/network.nix
    ./bakugo/nfs.nix
    "${self}/nixos/docker.nix"
    "${self}/nixos/nix.nix"
    "${self}/nixos/location.nix"
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    graphics.enable = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "23.11";
}
