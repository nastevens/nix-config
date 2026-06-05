lockfile := "flake.lock"

# List available justfile jobs
default:
  @just --list --justfile {{justfile()}}

# Update input flake versions
up:
  nix flake update
  git diff --quiet -- {{lockfile}} && \
    git diff --staged --quiet -- {{lockfile}} || \
    git commit -m "nix: update flake.lock" -- {{lockfile}}

# Build NixOS with high verbosity. Extra arguments are passed nixos-rebuild
build *args:
  nixos-rebuild build --flake . --no-link --show-trace {{args}}

# Build NixOS and use it on the next boot
boot:
  sudo nixos-rebuild boot --flake .

# Build NixOS and hot-switch to the new configuration
switch:
  sudo nixos-rebuild switch --flake .

# Update specific input
upp +inputs:
  nix flake update {{inputs}}

# Start a Nix REPL
repl:
  nix repl -f flake:nixpkgs

# Run all maintenance ops
clean: gc optimize clean-rust clean-kondo

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

# Clean up Rust build cache
clean-rust:
  cargo-cache --autoclean-expensive

# Clean up project build files
clean-kondo:
    kondo ~/dev ~/foss

# Print active gc-roots (i.e. root directories that nix won't clean up)
gc-roots:
    sudo -i nix-store --gc --print-roots | \
      egrep -v '^(/nix/var|/run/current-system|/run/booted-system|/proc|{memory|{censored)'
