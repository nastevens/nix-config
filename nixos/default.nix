{ self, config, ... }:

{
  flake = {
    nixosModules = {
      default.imports = [
        self.nixosModules.home-manager
        ./i18n.nix
        ./ssh.nix
        ./user.nix
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            btrfs-progs
            curl
            diskonaut
            git
            killall
            pciutils
            wget
            wireguard-tools
          ];

          programs.zsh.enable = true;
          services.tailscale.enable = true;
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
