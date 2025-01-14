{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
    self.nixosModules.desktop
    ./boot.nix
    ./network.nix
    ./nfs.nix
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
