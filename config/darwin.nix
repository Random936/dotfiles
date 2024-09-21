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

    # Move Window to Space #
    cmd - 1 : yabai -m window --space 1;
    cmd - 2 : yabai -m window --space 2;
    cmd - 3 : yabai -m window --space 3;
    cmd - 4 : yabai -m window --space 4;
    cmd - 5 : yabai -m window --space 5;
    cmd - 6 : yabai -m window --space 6;
    cmd - 7 : yabai -m window --space 7;
    cmd - 8 : yabai -m window --space 8;
    cmd - 9 : yabai -m window --space 9;
    cmd - 0 : yabai -m window --space 0;

    # Flip Window Axis
    shift + cmd - y : yabai -m space --mirror y-axis
    shift + cmd - x : yabai -m space --mirror x-axis

    # Full Screen Window
    cmd - f : yabai -m window --toggle zoom-fullscreen

    # Reload skhd config
    shift + cmd - r : echo "Reloading skhd config" && skhd --reload
    '';
  };

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;

    config = {
      focus_follows_mouse          = "autoraise";
      mouse_follows_focus          = "off";
      window_placement             = "second_child";
      window_opacity               = "off";
      window_opacity_duration      = "0.0";
      window_border                = "on";
      window_border_placement      = "inset";
      window_border_width          = 2;
      window_border_radius         = 3;
      active_window_border_topmost = "off";
      window_topmost               = "on";
      window_shadow                = "float";
      active_window_border_color   = "0xff5c7e81";
      normal_window_border_color   = "0xff505050";
      insert_window_border_color   = "0xffd75f5f";
      active_window_opacity        = "1.0";
      normal_window_opacity        = "1.0";
      split_ratio                  = "0.50";
      auto_balance                 = "on";
      mouse_modifier               = "fn";
      mouse_action1                = "move";
      mouse_action2                = "resize";
      layout                       = "bsp";
      top_padding                  = 10;
      bottom_padding               = 10;
      left_padding                 = 10;
      right_padding                = 10;
      window_gap                   = 10;
    };

    extraConfig = ''
    yabai -m rule --add app="^System Settings$" manage=off
    yabai -m rule --add app="^Calculator$" manage=off
    '';
  };

  system.stateVersion = 4;
}
