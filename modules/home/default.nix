{ ... }:

{
  imports = [
    ./chawan.nix
    ./cli.nix
    ./git
    ./gpg.nix
    ./tealdeer.nix
    ./tmux
    ./yazi.nix
    ./zsh
  ];
  home.stateVersion = "23.11";
}
