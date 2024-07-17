{ config, pkgs, inputs, ... }: {

  imports = [
    ../hardware/media.nix
    ./headless.nix
  ];

  users.users.media = import ./user.nix;
  networking.hostName = "r330-media";

  # Conigure a static IP address.
  networking.defaultGateway = "192.168.8.1";
  networking.nameservers = [ "192.168.8.1" ];
  networking.firewall.allowedTCPPorts = [ 80 443 32400 ];
  networking.interfaces.ens18.ipv4.addresses = [
    {
      address = "192.168.8.5";
      prefixLength = 24;
    }
  ];
}
