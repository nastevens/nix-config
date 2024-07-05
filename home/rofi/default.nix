{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./theme.rasi;
  };

  #xdg.configFile."rofi/config.rasi" = builtins.readFile ./config.rasi;
}

