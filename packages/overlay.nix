{ ... }:

self: super: {
  git-utils = self.callPackage ./git-utils { };
  open-slug = self.callPackage ./scripts/open-slug.nix { };
}
