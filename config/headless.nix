{ config, pkgs, inputs, ... }: {

  imports = [ ./shared.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Qemu guest
  services.qemuGuest.enable = true;

  system.stateVersion = "24.05";
}
