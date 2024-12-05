{ lib, config, pkgs, ... }: {
  # Hacking specific packages.
  home.packages = (with pkgs; [
    gdb
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
    strace
    strace
    openssl
    remmina
    netexec
    pwntools
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
