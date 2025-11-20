{
  description = "Nick's Nix";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    github-gitignore = {
      flake = false;
      url = "github:github/gitignore";
    };
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    hyprportal = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
    };
    nixos-unified.url = "github:srid/nixos-unified";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim";
    };
  };

  outputs =
    inputs:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
    };

}
