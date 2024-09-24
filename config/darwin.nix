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
      "wireguard-tools"
      "coreutils"
      "watch"
    ];
    casks = [
      "scroll-reverser"
      "google-chrome"
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

  # MacOS Changes
  system.defaults.dock.autohide = true;
  system.startup.chime = false;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  users.users.jadenmaxwell = {
    name = "jadenmaxwell";
    home = "/Users/jadenmaxwell";
  };

  # Window Manager
  services.skhd = {
    enable = true;
    skhdConfig = ''
    # Config intended for use with Yabai on MacOS

    # Switching Window Focus
    cmd - h : yabai -m window --focus west
    cmd - j : yabai -m window --focus south
    cmd - k : yabai -m window --focus north
    cmd - l : yabai -m window --focus east

    # Swap Windows
    shift + cmd - h : yabai -m window --swap west
    shift + cmd - j : yabai -m window --swap south
    shift + cmd - k : yabai -m window --swap north
    shift + cmd - l : yabai -m window --swap east

    # Focus on Space #
    cmd - 1 : yabai -m space --focus 1
    cmd - 2 : yabai -m space --focus 2
    cmd - 3 : yabai -m space --focus 3
    cmd - 4 : yabai -m space --focus 4
    cmd - 5 : yabai -m space --focus 5
    cmd - 6 : yabai -m space --focus 6
    cmd - 7 : yabai -m space --focus 7
    cmd - 8 : yabai -m space --focus 8
    cmd - 9 : yabai -m space --focus 9

    # Move Window to Space #
    shift + cmd - 1 : yabai -m window --space 1
    shift + cmd - 2 : yabai -m window --space 2
    shift + cmd - 3 : yabai -m window --space 3
    shift + cmd - 4 : yabai -m window --space 4
    shift + cmd - 5 : yabai -m window --space 5
    shift + cmd - 6 : yabai -m window --space 6
    shift + cmd - 7 : yabai -m window --space 7
    shift + cmd - 8 : yabai -m window --space 8
    shift + cmd - 9 : yabai -m window --space 9

    # Create/Destroy windows
    shift + cmd - c : yabai -m space --create
    shift + cmd - d : yabai -m space --destroy

    # Toggle window split
    cmd - e : yabai -m window --toggle split

    # Full Screen Window
    cmd - f : yabai -m window --toggle zoom-fullscreen

    # Close window with i3 keybinding
    cmd - q : yabai -m window --close

    # Application shortcuts
    shift + cmd - e : emacs
    shift + cmd - f : osascript -e 'tell application "Google Chrome" to make new window'
    cmd - return : osascript -e 'tell application "iTerm2" to create window with default profile'

    # Reload skhd config
    shift + cmd - r : ${pkgs.skhd}/bin/skhd -r
    '';
  };

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;

    config = {
      layout                       = "bsp";
      mouse_follows_focus          = "on";
      focus_follows_mouse          = "autoraise";
      window_placement             = "second_child";
      auto_balance                 = "on";
      mouse_modifier               = "fn";
      mouse_action1                = "move";
      mouse_action2                = "resize";
    };

    extraConfig = ''
    yabai -m rule --add app="^System Settings$" manage=off
    yabai -m rule --add app="^Calculator$" manage=off
    '';
  };

  system.stateVersion = 4;
}
