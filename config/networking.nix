{ ip_address, hostname, open_ports, lib }: let
  gateway_ip = "192.168.100.1";
in {
  # Configure hostname.
  networking.hostName = hostname;

  # Conigure a static IP address.
  networking.useDHCP = false;
  networking.useNetworkd = true;

  # Bug fix
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

  networking.defaultGateway = {
      address = gateway_ip;
      interface = "enp6s18";
  };

  networking.nameservers = [ gateway_ip ];
  networking.firewall.allowedTCPPorts = open_ports;
  networking.interfaces.enp6s18.ipv4.addresses = [
    {
      address = ip_address;
      prefixLength = 24;
    }
  ];
}
