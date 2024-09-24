{ pkgs, ... }: {

  # Hacking specific packages.
  home.packages = with pkgs; [
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
    inetutils
    thc-hydra
    exploitdb
    responder
    burpsuite
    evil-winrm
    feroxbuster
    crackmapexec
    (wordlists.override {
      lists = with pkgs; [
        rockyou
        seclists
      ];
    })
  ];

}
