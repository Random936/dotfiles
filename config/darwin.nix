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
    taps = [
      "nikitabobko/tap"
    ];
    brews = [
      "wireguard-tools"
      "bitwarden-cli"
      "coreutils"
      "watch"
    ];
    casks = [
      "scroll-reverser"
      "google-chrome"
      "instantview"
      "aerospace"
      "bitwarden"
      "tailscale"
      "discord"
      "iterm2"
      "zoom"
      "vlc"
    ];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Extra activation scripts
  system.activationScripts.extraActivation.text = ''
  softwareupdate --install-rosetta --agree-to-license
  '';

  # Keyboard and Mouse
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
    swapLeftCommandAndLeftAlt = true;
  };

  # MacOS Changes
  system.defaults.dock.autohide = true;
  system.startup.chime = false;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  users.users.jadenmaxwell = {
    name = "jadenmaxwell";
    home = "/Users/jadenmaxwell";
  };

  system.stateVersion = 4;
}
