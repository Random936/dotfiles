{ pkgs, lib, config, ... }: rec {
  tpm = pkgs.callPackage ./tpm {};
  evil-winrm = pkgs.callPackage ./evil-winrm {};
  bitwarden-cli-bin = pkgs.callPackage ./bitwarden-cli-bin {};
}
