{ flake, lib, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  me = flake.config.me;
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-32.3.3"
      ];
    };
    overlays = lib.attrValues self.overlays;
  };

  nix = {
    # Make `nix shell` etc use pinned nixpkgs
    registry.nixpkgs.flake = flake.inputs.nixpkgs;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      # Nullify registry for purity.
      flake-registry = builtins.toFile
        "empty-flake-registry.json" ''{"flakes":[],"version":2}'';
      max-jobs = "auto";
      trusted-users = [ "root" me.username ];
    };
  };
}
