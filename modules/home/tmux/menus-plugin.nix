{
  pkgs,
  lib,
  fetchFromGitHub,
  tmuxPlugins,
  cacheHome,
  ...
}:
{
  menus = tmuxPlugins.mkTmuxPlugin rec {
    pluginName = "menus";
    version = "7fbd66d466143457f4cc990643cc0c333d1660a4";
    src = fetchFromGitHub {
      owner = "jaclu";
      repo = "tmux-menus";
      rev = "${version}";
      hash = "sha256-7LO+8H+ulrgD559TiitLQLWOWf4CPp/sKlD4Dc/tiPI=";
    };
    # Plugin is installed immutable so cache can't be alongside it
    postInstall = ''
      sed -i -e 's|"$D_TM_BASE_PATH"/cache|"${cacheHome}/tmux-menus/cache"|' $target/scripts/utils.sh
    '';
    meta = {
      homepage = "https://github.com/jaclu/tmux-menus";
      description = "Popup menus to help with managing your environment";
      license = lib.licenses.mit;
    };
  };
}
