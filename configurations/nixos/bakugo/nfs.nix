{ ... }:
let
  vashNfs = { name, extraOptions ? [ ] }: {
    device = "vash:/volume1/${name}";
    fsType = "nfs";
    options = [
      "user"
      "soft"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ] ++ extraOptions;
  };
in
{
  fileSystems = {
    "/home/nick/nas/media" = vashNfs { name = "media"; };
    "/home/nick/nas/taxport" = vashNfs { name = "taxport"; };
    "/home/nick/nas/torrents" = vashNfs { name = "torrents"; };
    "/home/nick/nas/mythtv" = vashNfs { name = "mythtv"; };
    "/home/nick/nas/NetBackup" = vashNfs {
      name = "NetBackup";
      extraOptions = [ "ro" ];
    };
  };
}
