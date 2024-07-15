{ ... }:

final: prev: {
  git-utils = prev.callPackage ./git-utils { };
  open-slug = prev.callPackage ./scripts/open-slug.nix { };
}
