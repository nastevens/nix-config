{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
    self.nixosModules.desktop
    self.nixosModules.docker
    self.nixosModules.location
    self.nixosModules.nix
    ./boot.nix
    ./network.nix
    ./nfs.nix
    ./ssh.nix
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    graphics.enable = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "23.11";
}
