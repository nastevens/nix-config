{
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };
  programs.zsh.shellAliases = {
    ls = "eza";
    ll = "eza -lh";
    la = "eza -a";
    lla = "eza -la";
  };
}
