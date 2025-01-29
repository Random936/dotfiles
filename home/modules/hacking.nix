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
    nuclei
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
    openldap
    rustscan
    inetutils
    wireshark
    thc-hydra
    exploitdb
    responder
    burpsuite
    evil-winrm
    cifs-utils
    feroxbuster
    (wordlists.override {
      lists = with pkgs; [
        rockyou
        seclists
      ];
    })
  ]);

}
