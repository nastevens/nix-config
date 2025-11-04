{
  description = "Nick's Nix";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    github-gitignore.url = "github:github/gitignore";
    github-gitignore.flake = false;
    hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprportal.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    hyprportal.inputs.nixpkgs.follows = "nixpkgs";
    nixos-unified.url = "github:srid/nixos-unified";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
