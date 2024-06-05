{ config, pkgs, lib, ... }: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Path fix for GUI applications.
  launchd.user.envVariables.PATH = config.environment.systemPath;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    iterm2
    discord
  ];

  homebrew = {
    enable = true;
    brews = [
      "coreutils"
    ];
    casks = [
      "microsoft-edge"
      "instantview"
      "bitwarden"
      "tailscale"
      "nextcloud"
      "nordvpn"
      "docker"
      "vlc"
    ];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Keyboard and Mouse
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = true;
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
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
