{ pkgs, lib, config, ... }: rec {
  tpm = pkgs.callPackage ./tpm {};
  evil-winrm = pkgs.callPackage ./evil-winrm {};
}
