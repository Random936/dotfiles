{ lib, config, pkgs, ... }: {
  # Hacking specific packages.
  home.packages = (with pkgs; [
    yara
    nmap
    john
    ffuf
    amass
    nikto
    rlwrap
    sqlmap
    wpscan
    ghidra
    pwndbg
    openssl
    remmina
    netexec
    rustscan
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
