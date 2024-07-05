{ inputs, config, pkgs, ... }: {

  # Hacking specific packages.
  home.packages = with pkgs; [
    yara
    nmap
    john
    ffuf
    nikto
    sqlmap
    thc-hydra
    exploitdb
    feroxbuster
    (wordlists.override {
      lists = with pkgs; [
        rockyou
        seclists
      ];
    })
  ];

}
