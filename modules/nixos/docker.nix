{ flake, pkgs, ... }:

let
  me = flake.config.me;
in
{
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
  users.users.${me.username}.extraGroups = [ "docker" ];
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      dns = [ "1.1.1.1" "1.0.0.1" ];
    };
    storageDriver = "btrfs";
  };
}
