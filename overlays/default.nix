{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  packages = self + /packages;
in
(final: prev: {
  # Downgrade to avoid 1Password GUI glitch - remove @ 8.11.18 release
  git-utils = final.callPackage "${packages}/git-utils" { };
  open-slug = final.callPackage "${packages}/open-slug" { };
  prusaslicer-rename = final.callPackage "${packages}/prusaslicer-rename" { };
})
