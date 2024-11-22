{ lib, config, pkgs, ... }: {
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
    pwndbg
    openssl
    remmina
    netexec
    inetutils
    thc-hydra
    exploitdb
    responder
    burpsuite
    evil-winrm
    feroxbuster
    (wordlists.override {
      lists = with pkgs; [
        rockyou
        seclists
      ];
    })
  ]);

}
