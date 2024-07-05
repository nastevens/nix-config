{ pkgs, lib, fetchFromGitHub, tmuxPlugins, ... }: {
  suspend = tmuxPlugins.mkTmuxPlugin rec {
    pluginName = "suspend";
    version = "1a2f806666e0bfed37535372279fa00d27d50d14";
    src = fetchFromGitHub {
      owner = "MunifTanjim";
      repo = "tmux-suspend";
      rev = "${version}";
      hash = "sha256-+1fKkwDmr5iqro0XeL8gkjOGGB/YHBD25NG+w3iW+0g=";
    };
    meta = {
      homepage = "https://github.com/MunifTanjim/tmux-suspend";
      description = ''
        Plugin that lets you suspend local tmux session, so that you can
        work with nested remote tmux session painlessly.
      '';
      license = lib.licenses.mit;
    };
  };
}
