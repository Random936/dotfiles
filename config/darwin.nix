{ config, pkgs, lib, ... }: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Path fix for GUI applications.
  launchd.user.envVariables.PATH = config.environment.systemPath;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    brews = [
      "coreutils"
      "watch"
    ];
    casks = [
      "google-chrome"
      "scroll-reverser"
      "instantview"
      "nextcloud"
      "tailscale"
      "discord"
      "iterm2"
      "vlc"
    ];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Keyboard and Mouse
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
    swapLeftCommandAndLeftAlt = true;
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  users.users.jadenmaxwell = {
    name = "jadenmaxwell";
    home = "/Users/jadenmaxwell";
  };

  # Used for backwards compatibility.

  system.stateVersion = 4;
}
