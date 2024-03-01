deploy:
  sudo nixos-rebuild switch --flake .

debug:
  sudo nixos-rebuild switch --flake . --show-trace --verbose

up:
  nix flake update

# Update specific input
# usage: make upp i=home-manager
upp:
  nix flake lock --update-input $(i)

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage --delete-old

waybar-clean:
    rm -rf ${HOME}/.config/waybar

waybar-dev: waybar-clean
    mkdir ${HOME}/.config/waybar
    ln -s {{justfile_directory()}}/users/common/waybar/config.json ${HOME}/.config/waybar/config
    ln -s {{justfile_directory()}}/users/common/waybar/style.css ${HOME}/.config/waybar/style.css

hyprland-clean:
    rm -rf ${HOME}/.config/hypr

hyprland-dev: hyprland-clean
    mkdir ${HOME}/.config/hypr
    ln -s {{justfile_directory()}}/users/common/hypr/hyprland.conf ${HOME}/.config/hypr/hyprland.conf
