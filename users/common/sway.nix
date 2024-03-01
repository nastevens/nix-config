{ pkgs, ... }: {
  home.packages = with pkgs; [ mako wl-clipboard shotman ];
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      output = { "Samsung C49RG9x" = { mode = "5120x1440@120Hz"; }; };
      terminal = "alacritty";
    };
    extraConfig = ''
      output "*" bg /etc/moon_landing.jpg fill
    '';
  };
  #  programs.waybar = {
  #    enable = true;
  #    settings = {
  #        mainBar = {
  #            modules-center = [ "clock" ];
  #            position = "left";
  #            clock = {
  #                rotate = 90;
  #            };
  #        };
  #    };
  #  };
}
