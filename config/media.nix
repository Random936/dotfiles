{ config, pkgs, inputs, ... }: {

  imports = [
    ../hardware/media.nix
    ./headless.nix
  ];

  users.users.media = import ./user.nix;
  networking.hostname = "r330-media";
}
