{ ... }: {
  imports = [
    ../common
    #../common/sway.nix
  ];

  home = {
    username = "nick";
    homeDirectory = "/home/nick";
  };

  home.stateVersion = "23.11";
}
