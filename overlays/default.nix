{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  packages = self + /packages;
in
(
  final: prev:
  let
    pkgs-1password_81114 = import inputs.nixpkgs-1password_81114 {
      inherit (prev) config;
      inherit (prev.stdenv.hostPlatform) system;
    };
  in
  {
    # Downgrade to avoid 1Password GUI glitch - remove @ 8.11.18 release
    inherit (pkgs-1password_81114) _1password-gui;
    git-utils = final.callPackage "${packages}/git-utils" { };
    open-slug = final.callPackage "${packages}/open-slug" { };
    prusaslicer-rename = final.callPackage "${packages}/prusaslicer-rename" { };
  }
)
