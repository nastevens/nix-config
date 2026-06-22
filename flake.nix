{
  description = "Nick's Nix";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    github-gitignore = {
      url = "github:github/gitignore";
      flake = false;
    };
    hardware = {
      url = "github:nixos/nixos-hardware";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprportal = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
    nixos-unified = {
      url = "github:srid/nixos-unified";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
    };
    systems = {
      url = "github:nix-systems/default-linux";
    };
  };

  outputs =
    inputs:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
    };

}
