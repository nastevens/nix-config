{ flake, pkgs, ... }:

let
  me = flake.config.me;
in
{
  programs.zsh.enable = true;
  users.users.${me.username} = {
    description = me.name;
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    shell = pkgs.zsh;
  };
}
