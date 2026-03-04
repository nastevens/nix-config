{
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };
  programs.zsh.shellAliases = {
    ls = "eza";
    ll = "ls -lh";
    la = "ls -a";
    lla = "ls -la";
  };
}
