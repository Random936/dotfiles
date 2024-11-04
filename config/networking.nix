{ ip_address, hostname, open_ports }:
{
  # Configure hostname.
  networking.hostName = hostname;

  # Conigure a static IP address.
  networking.useDHCP = false;
  networking.useNetworkd= true;

  # Bug fix
  systemd.services.systemd-networkd-wait-online.enable = false;

  networking.defaultGateway = {
      address = ip_address;
      interface = "enp6s18";
  };

  networking.nameservers = [ "192.168.100.1" ];
  networking.firewall.allowedTCPPorts = open_ports;
  networking.interfaces.enp6s18.ipv4.addresses = [
    {
      address = ip_address;
      prefixLength = 24;
    }
  ];
}
