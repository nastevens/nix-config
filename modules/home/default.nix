{ ... }:

{
  imports = [
    ./cli.nix
    ./git
    ./tealdeer.nix
    ./tmux
    ./yazi.nix
    ./zsh
  ];
  home.stateVersion = "23.11";
}
