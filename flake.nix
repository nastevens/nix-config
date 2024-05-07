{
  description = "Nick's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware";

    hypridle.url = "github:hyprwm/hypridle";

    hyprpaper.url = "github:hyprwm/hyprpaper";

    hyprpicker.url = "github:hyprwm/hyprpicker";

    hyprportal.url = "github:hyprwm/xdg-desktop-portal-hyprland";

    github-gitignore = {
      url = "github:github/gitignore";
      flake = false;
    };

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , rust-overlay
    , ...
    }@inputs:
    let
      inherit (self) outputs;

      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];

      mkSystem = modules:
        nixpkgs.lib.nixosSystem rec {
          inherit modules;
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs outputs;
            pkgs-unstable = import nixpkgs-unstable { inherit system; };
          };
        };
    in
    {
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; });

      # Nix code formatter
      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);

      homeManagerModules = import ./modules/home-manager;

      nixosModules = import ./modules/nixos;

      nixosConfigurations = {
        bakugo = mkSystem [
          ./hosts/bakugo
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            # https://github.com/oxalica/rust-overlay/blob/master/README.md#cheat-sheet-common-usage-of-rust-bin
            environment.systemPackages = [
              (pkgs.rust-bin.stable.latest.default.override {
                extensions = [ "rust-src" ];
                targets = [ "armv7-unknown-linux-gnueabihf" ];
              })
            ];
          })
        ];
      };

      overlays = import ./overlays { inherit inputs; };
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; });
    };
}
