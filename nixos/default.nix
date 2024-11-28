{ self, config, ... }:

{
  flake = {
    nixosModules = {
      default.imports = [
        self.nixosModules.home-manager
        ./i18n.nix
        ./ssh.nix
        # ./tailscale.nix
        ./user.nix
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            btrfs-progs
            curl
            diskonaut
            fdupes
            git
            killall
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

      desktop.imports = [
        self.nixosModules.default
        ./1password.nix
        ./desktop.nix
        ./sound.nix
        ./steam.nix
        ./virt.nix
        ({ ... }: {
          home-manager.users.${config.me.username} = {
            imports = [
              self.homeModules.desktop
            ];
          };
        })
      ];
    };
  };
}
