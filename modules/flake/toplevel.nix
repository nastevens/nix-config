{ inputs, ... }:

{
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];
  perSystem = { self', pkgs, ... }: {
    # Used by 'nix fmt'
    formatter = pkgs.nixpkgs-fmt;
  };
}
