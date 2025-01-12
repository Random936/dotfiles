{ config, pkgs, inputs, ... }: {

  imports = [
    ../hardware/logging.nix
    ./headless.nix
    (import ./networking.nix {
        hostname = "r330-logging";
        ip_address = "192.168.100.41";
        open_ports = [];
        inherit lib;
    })
  ];

  users.users.logging = import ./user.nix;

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
