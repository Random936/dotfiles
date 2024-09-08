{ config, pkgs, inputs, ... }: {

  imports = [
    ../hardware/logging.nix
    ./headless.nix
  ];

  users.users.logging = import ./user.nix;
  networking.hostName = "r330-logging";

  # Conigure a static IP address.
  networking.defaultGateway = "192.168.8.1";
  networking.nameservers = [ "192.168.8.1" ];
  #networking.firewall.allowedTCPPorts = [ ];
  networking.interfaces.ens18.ipv4.addresses = [
    {
      address = "192.168.8.8";
      prefixLength = 24;
    }
  ];

  environment.systemPackages = with pkgs; [
    suricata
  ];
}
