# Generic user configuration.
# Don't forget to set a password with ‘passwd’.
{
  isNormalUser = true;
  useDefaultShell = true;
  description = "random";
  extraGroups = [ "networkmanager" "wheel" "docker" ];
}
