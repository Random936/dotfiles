{ config, pkgs, inputs, ... }: {

  imports = [
    ../hardware/media.nix
    ./headless.nix
    (import ./networking.nix { 
      hostname = "r330-media";
      ip_address = "192.168.100.40"; 
      open_ports = [ 80 443 32400 ];
    })
  ];

  users.users.media = import ./user.nix;

  # Setup drivers for NVIDIA GPU
  services.xserver = {
      enable = false;
      videoDrivers = [ "nvidia" ];
  };

  hardware = {
    nvidia = {
      open = false;
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      nvidiaSettings = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # Plex Setup
  services.plex = {
      enable = true;
      openFirewall = true;
      user = "media";
      dataDir = "/mnt/storage/plex";
  };

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

  # Enable Tailscale
  services.tailscale.enable = true;
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
}
