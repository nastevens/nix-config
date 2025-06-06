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
    nixos-unified.url = "github:srid/nixos-unified";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = inputs:
    inputs.nixos-unified.lib.mkFlake
      { inherit inputs; root = ./.; };

  # outputs = inputs@{ flake-parts, nixos-flake, self, ... }:
  #   flake-parts.lib.mkFlake { inherit inputs; } {
  #     imports = [
  #       nixos-flake.flakeModule
  #       ./home
  #       ./nixos
  #       ./users
  #     ];

  #     flake.nixosConfigurations =
  #       let
  #         hosts = builtins.readDir ./hosts;
  #         mkLinuxSystem = name: _: self.nixos-flake.lib.mkLinuxSystem ./hosts/${name};
  #       in
  #       builtins.mapAttrs mkLinuxSystem hosts;

  #     perSystem = { pkgs, self', ... }: {
  #       packages.default = self'.packages.activate;
  #     };

  #     systems = [ "x86_64-linux" "aarch64-linux" ];
  #   };

  # outputs =
  #   { self
  #   , nixpkgs
  #   , home-manager
  #   , rust-overlay
  #   , ...
  #   }@inputs:
  #   let
  #     inherit (self) outputs;

  #     forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];

  #     # Nix code formatter
  #     formatter =
  #       forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);

  #     nixosConfigurations = {
  #       bakugo = mkSystem [
  #         ./hosts/bakugo
  #         ({ pkgs, ... }: {
  #           nixpkgs.overlays = [ rust-overlay.overlays.default ];
  #           # https://github.com/oxalica/rust-overlay/blob/master/README.md#cheat-sheet-common-usage-of-rust-bin
  #           environment.systemPackages = [
  #             (pkgs.rust-bin.stable.latest.default.override {
  #               extensions = [ "rust-src" ];
  #               targets = [ "armv7-unknown-linux-gnueabihf" ];
  #             })
  #           ];
  #         })
  #       ];
  #     };

  #     overlays = import ./overlays { inherit inputs; };
  #     packages = forAllSystems (system:
  #       let pkgs = nixpkgs.legacyPackages.${system};
  #       in import ./pkgs { inherit pkgs; });
  #   };
}
