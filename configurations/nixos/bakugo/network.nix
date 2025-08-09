{ ... }:

{
  networking = {
    hostId = "8ad2bc62";
    hostName = "bakugo";
    useDHCP = false;
  };

  # Note on commented sections: on 2025-08-09 a lightning storm killed the NIC
  # on bakugo, so I am temporarily using a USB NIC. It also killed the port
  # bakugo was connected to on the Dream Machine, so VLAN for IoT network is
  # disabled.
  systemd.network = {
    enable = true;

    # netdevs = {
    #   "20-vlan3" = {
    #     netdevConfig = {
    #       Name = "vlan3";
    #       Kind = "vlan";
    #       Description = "IoT Network";
    #     };
    #     vlanConfig.Id = 3;
    #   };
    # };

    networks = {
      "30-wired" = {
        # Temporary USB NIC
        matchConfig.Name = "enp7s0f1u1";

        # matchConfig.Name = "enp6s0";
        # vlan = [ "vlan3" ];
        networkConfig = {
          DHCP = "ipv4";
          LinkLocalAddressing = "no";
        };
        linkConfig.RequiredForOnline = "yes";
        dhcpV4Config.UseDomains = "yes";
      };

      # "40-vlan3" = {
      #   matchConfig.Name = "vlan3";
      #   networkConfig = {
      #     DHCP = "ipv4";
      #     LinkLocalAddressing = "no";
      #     ConfigureWithoutCarrier = true;
      #   };
      #   linkConfig.RequiredForOnline = "no";
      # };
    };
  };

  services.resolved.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
