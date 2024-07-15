{ flake, ... }:

let
  me = flake.config.me;
in
{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.${me.username}.extraGroups = [ "libvirtd" ];
}
