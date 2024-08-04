# List available justfile jobs
default:
  @just --list --justfile {{justfile()}}

# Build NixOS and hot-switch to the new configuration
switch:
  sudo nixos-rebuild switch --flake .

# Build NixOS and use it on the next boot
boot:
  sudo nixos-rebuild boot --flake .

# Build NixOS
build:
  nixos-rebuild build --flake .

# Build NixOS with verbose error output
debug:
  nixos-rebuild build --flake . --show-trace --verbose

# Update input flake versions
up:
  nix flake update

# Update specific input
upp input:
  nix flake lock --update-input $(input)

# Start a Nix REPL
repl:
  nix repl -f flake:nixpkgs

# Run all maintenance ops
clean: gc optimize

# Garbage collect unused nix store entries
gc:
  # The home-manager profiles created through the NixOS module are not being
  # cleaned up for some reason. This manually prunes old versions.
  nix profile wipe-history \
    --profile ${HOME}/.local/state/nix/profiles/home-manager \
    --older-than 30d
  sudo nix-collect-garbage \
    --delete-older-than 30d \
    --option use-xdg-base-directories true

# Hard-link identical files in store
optimize:
  nix-store --optimise

# Print active gc-roots (i.e. root directories that nix won't clean up)
gc-roots:
    sudo -i nix-store --gc --print-roots | \
      egrep -v '^(/nix/var|/run/current-system|/run/booted-system|/proc|{memory|{censored)'
