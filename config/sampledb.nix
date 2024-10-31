{ config, pkgs, inputs, ... }: {

  imports = [
    ../hardware/sampledb.nix
    ./headless.nix
    (import ./networking.nix { 
      hostname = "sampledb-dev";
      ip_address = "192.168.100.42"; 
    })
  ];

  users.users.sampledb = import ./user.nix;
}
