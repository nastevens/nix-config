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

    # Downgrade to avoid 1Password GUI glitch - remove @ 8.11.18 release
    nixpkgs-1password_81114 = {
      url = "github:NixOS/nixpkgs/186d6ace1245bc1d56deffdc2cfc8901bae5962a";
    };
  };

  outputs =
    inputs:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
    };

}
