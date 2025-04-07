{ ... }:

{
  imports = [
    ./cli.nix
    ./git
    ./tealdeer.nix
    ./tmux
    ./zsh
  ];
  home.stateVersion = "23.11";
}
