{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    extraPackages = with pkgs; [ ueberzugpp ];
    shellWrapperName = "y";
    initLua = ''
      require("git"):setup {
        order = 1500,
      }
    '';
    keymap = { };
    plugins = {
      inherit (pkgs.yaziPlugins) git piper;
    };
    settings = {
      plugin.prepend_fetchers = [
        {
          id = "git";
          url = "*";
          run = "git";
        }

        {
          id = "git";
          url = "*/";
          run = "git";
        }
      ];
    };
  };
}
