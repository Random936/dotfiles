{ config, pkgs, lib, ... }: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      "nikitabobko/tap"
      "FelixKratz/formulae"
    ];
    brews = [
      "wireguard-tools"
      "bitwarden-cli"
      "sketchybar"
      "coreutils"
      "watch"
    ];
    casks = [
      "font-hack-nerd-font"
      "scroll-reverser"
      "google-chrome"
      "instantview"
      "flameshot"
      "aerospace"
      "bitwarden"
      "tailscale"
      "discord"
      "barrier"
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
  system = {
    startup.chime = false;
    defaults = {
      dock.autohide = true;
      NSGlobalDomain = {
        "com.apple.mouse.tapBehavior" = 1;
        _HIHideMenuBar = true;
      };
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  users.users.jadenmaxwell = {
    name = "jadenmaxwell";
    home = "/Users/jadenmaxwell";
  };

  system.stateVersion = 4;
}
