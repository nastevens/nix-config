{ ... }:

{
  networking = {
    hostId = "8ad2bc62";
    hostName = "bakugo";
    useDHCP = false;
  };

  systemd.network = {
    enable = true;

    netdevs = {
      "20-vlan3" = {
        netdevConfig = {
          Name = "vlan3";
          Kind = "vlan";
          Description = "IoT Network";
        };
        vlanConfig.Id = 3;
      };
    };

    networks = {
      "30-wired" = {
        matchConfig.Name = "enp5s0np0";
        vlan = [ "vlan3" ];
        networkConfig = {
          DHCP = "ipv4";
          LinkLocalAddressing = "no";
        };
        linkConfig.RequiredForOnline = "yes";
        dhcpV4Config.UseDomains = "yes";
      };

      "40-vlan3" = {
        matchConfig.Name = "vlan3";
        networkConfig = {
          DHCP = "ipv4";
          LinkLocalAddressing = "no";
          ConfigureWithoutCarrier = true;
        };
        linkConfig.RequiredForOnline = "no";
      };
    };
  };

  services.resolved.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
