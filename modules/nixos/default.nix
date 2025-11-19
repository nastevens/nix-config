{ flake, ... }:

let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{
  imports = [
    ./i18n.nix
    ./ssh.nix
    ./tailscale.nix
    ./user.nix
    (
      { pkgs, ... }:
      let
        nicksvim =
          self.nixvimConfigurations.${pkgs.stdenv.hostPlatform.system}.nicksvim.config.build.package;
      in
      {
        environment.systemPackages = with pkgs; [
          btrfs-progs
          curl
          fdupes
          git
          killall
          ncdu
          nicksvim
          pciutils
          wget
          wireguard-tools
        ];
      }
    )
    (
      { ... }:
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${config.me.username}.imports = [
            self.homeModules.default
          ];
        };
      }
    )
  ];
}
