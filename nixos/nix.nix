{ flake, pkgs, ... }:

let
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
    overlays = [
      (import ../packages/overlay.nix { inherit flake; inherit (pkgs) system; })
    ];
  };

  nix = {
    # Make `nix shell` etc use pinned nixpkgs
    registry.nixpkgs.flake = flake.inputs.nixpkgs;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" me.username ];
    };
  };
}
