{ ... }:

{
  flake = {
    homeModules = {
      default = {
        imports = [ ];
        home.stateVersion = "23.11";
      };
      desktop = {
        imports = [
          ./default_old.nix
          ./virt.nix
        ];
      };
    };
  };
}
