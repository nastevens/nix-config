{
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };
  home.sessionVariables = { _ZO_ECHO = 1; };
}
