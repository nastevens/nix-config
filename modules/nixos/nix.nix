{ flake, lib, ... }:

let
  inherit (flake.config) me;
  inherit (flake.inputs) nixpkgs self;
in
{
  nixpkgs = {
    config = {
      allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "1password"
          "1password-cli"
          "1password-gui"
          "discord"
          "slack"
          "steam"
          "steam-unwrapped"
          "vista-fonts"
          "zoom"
        ];
    };
    overlays = lib.attrValues self.overlays;
  };

  nix = {
    # Make `nix shell` etc use pinned nixpkgs
    registry.nixpkgs.flake = nixpkgs;

    settings = {
      download-buffer-size = 500000000; # 500MB
      experimental-features = [
        "flakes"
        "nix-command"
      ];

      # Nullify registry for purity.
      flake-registry = builtins.toFile "empty-flake-registry.json" (
        builtins.toJSON {
          flakes = [ ];
          version = 2;
        }
      );

      max-jobs = "auto";
      trusted-users = [
        "root"
        me.username
      ];
    };
  };
}
