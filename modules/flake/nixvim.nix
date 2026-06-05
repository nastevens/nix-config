{ inputs, self, ... }:
{
  imports = [
    inputs.nixvim.flakeModules.default
  ];
  nixvim = {
    checks.enable = true;
    packages.enable = true;
  };
  perSystem =
    { system, ... }:
    {
      nixvimConfigurations = {
        nicksvim = inputs.nixvim.lib.evalNixvim {
          inherit system;
          extraSpecialArgs = {
            inherit (inputs) nixpkgs;
          };
          modules = [
            "${self}/nixvim"
          ];
        };
      };
    };
}
