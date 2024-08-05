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

  # Nextcloud Setup
  services.nextcloud = {
      enable = true;
      configureRedis = true;
      database.createLocally = true;
      autoUpdateApps.enable = true;
      https = true;

      hostName = "nextcloud.randomctf.com";
      datadir = "/mnt/storage/nextcloud";
      maxUploadSize = "50G";

      settings = {
          overwriteprotocol = "https";
          htaccess.rewriteBase = "/";
      };

      config = {
          dbtype = "mysql";
          adminpassFile = "/var/nextcloud-admin-pass";
      };
  };

  # NGINX Reverse Proxy Setup
  services.nginx = {
    enable = true;
    virtualHosts.${config.services.nextcloud.hostName} = {
      enableACME = true;
      forceSSL = true;
    };
  };

  security.acme = {
    acceptTerms = true;
    certs = {
        ${config.services.nextcloud.hostName}.email = "admin@randomctf.com";
    };
  };
}
