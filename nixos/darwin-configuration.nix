{ config, pkgs, ... }:

{
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    iterm2
    discord
    docker
  ];

  homebrew = {
    enable = true;
    casks = [
      "microsoft-edge"
      "bitwarden"
      "tailscale"
      "nextcloud"
      "nordvpn"
    ];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  users.users.jadenmaxwell = {
    name = "jadenmaxwell";
    home = "/Users/jadenmaxwell";
  };

  # Used for backwards compatibility.
  system.stateVersion = 4;
}
