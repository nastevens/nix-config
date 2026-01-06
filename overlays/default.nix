{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  packages = self + /packages;
in
(final: prev: {
  git-utils = final.callPackage "${packages}/git-utils" { };
  open-slug = final.callPackage "${packages}/open-slug" { };
  prusaslicer-rename = final.callPackage "${packages}/prusaslicer-rename" { };
})
