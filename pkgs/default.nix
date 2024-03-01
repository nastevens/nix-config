{ pkgs }: {
  git-utils = pkgs.callPackage ./git-utils { };
  open-slug = pkgs.callPackage ./scripts/open-slug.nix { };
}
