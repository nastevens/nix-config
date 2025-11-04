{ flake, lib, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  me = flake.config.me;
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
    registry.nixpkgs.flake = flake.inputs.nixpkgs;

    settings = {
      download-buffer-size = 500000000; # 500MB
      experimental-features = [ "nix-command" "flakes" ];
      # Nullify registry for purity.
      flake-registry = builtins.toFile
        "empty-flake-registry.json" ''{"flakes":[],"version":2}'';
      max-jobs = "auto";
      trusted-users = [ "root" me.username ];
    };
  };
}
