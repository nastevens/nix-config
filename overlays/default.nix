{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  packages = self + /packages;
in
final: prev: {
  git-utils = final.callPackage "${packages}/git-utils" { };
  open-slug = prev.callPackage "${packages}/open-slug" { };
}
