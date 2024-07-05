{ config, pkgs, inputs, ... }: {

  imports = [
    ../hardware/media.nix
    ./headless.nix
  ];

  users.users.media = import ./user.nix;
  networking.hostName = "r330-media";
}
