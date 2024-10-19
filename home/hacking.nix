{ lib, config, pkgs, ... }:
let
  mypkgs = import ../packages/all-packages.nix {
    inherit pkgs lib config;
  };
in {
  # Hacking specific packages.
  home.packages = (with pkgs; [
    yara
    nmap
    john
    ffuf
    amass
    nikto
    sqlmap
    wpscan
    openssl
    remmina
    netexec
    inetutils
    thc-hydra
    exploitdb
    responder
    burpsuite
    feroxbuster
    (wordlists.override {
      lists = with pkgs; [
        rockyou
        seclists
      ];
    })
  ]) ++ (with mypkgs; [
    evil-winrm
    binaryninja
  ]);

}
