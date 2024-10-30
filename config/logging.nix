{ config, pkgs, inputs, ... }: {

  imports = [
    ../hardware/logging.nix
    ./headless.nix
  ];

  users.users.logging = import ./user.nix;
  networking.hostName = "r330-logging";

  # Conigure a static IP address.
  networking.defaultGateway = "192.168.100.1";
  networking.nameservers = [ "192.168.100.1" ];
  #networking.firewall.allowedTCPPorts = [ ];
  networking.interfaces.ens18.ipv4.addresses = [
    {
      address = "192.168.100.41";
      prefixLength = 24;
    }
  ];

  environment.systemPackages = with pkgs; [
    suricata
  ];

  systemd.services.suricata = {
    enable = true;
    description = "Suricata IDS/IPS";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      type = "simple";
      ExecStart = "${pkgs.suricata}/bin/suricata -c '/home/logging/suricata.yaml' -i ens18";
      Restart = "on-failure";
    };
  };
}
