{ flake, ... }:

let
  inherit (flake) config inputs;
  inherit (inputs) self;
  inherit (inputs.nixvim.nixosModules) nixvim;
in
{
  imports = [
    nixvim
    ./i18n.nix
    ./neovim
    ./ssh.nix
    ./tailscale.nix
    ./user.nix
    (
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          btrfs-progs
          curl
          fdupes
          git
          killall
          ncdu
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
