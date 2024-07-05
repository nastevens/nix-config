{ flake, pkgs, ... }:

let
  me = flake.config.me;
in
{
  users.users.${me.username} = {
    description = me.name;
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = me.sshPublicKeys;
    shell = pkgs.zsh;
  };
}
