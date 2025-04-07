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
    ({ pkgs, ... }: {
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
    })
    ({ ... }: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${config.me.username}.imports = [
          self.homeModules.default
        ];
      };
    })
  ];
}
