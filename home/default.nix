{ ... }:

{
  flake = {
    homeModules = {
      default = {
        imports = [
          ./cli.nix
          ./git
          ./tealdeer.nix
          ./tmux
          ./zsh
        ];
        home.stateVersion = "23.11";
      };
      desktop = {
        imports = [
          ./alacritty.nix
          ./default_old.nix
          ./dunst.nix
          ./firefox.nix
          ./hypr
          ./rofi
          ./virt.nix
          ./waybar
        ];
      };
    };
  };
}
