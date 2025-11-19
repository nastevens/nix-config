{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./theme.rasi;
  };

  #xdg.configFile."rofi/config.rasi" = builtins.readFile ./config.rasi;
}
