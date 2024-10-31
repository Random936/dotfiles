{
  lib,
  buildFHSEnv,
  writeScript,
  pkgs,
  python311
}:
buildFHSEnv rec {
  name = "binaryninja";

  python = python311.withPackages (ps: with ps; [
    torch
    pip
  ]);

  targetPkgs = pkgs: with pkgs; [
      dbus
      fontconfig
      freetype
      libGL
      libxkbcommon
      python
      xorg.libXi
      xorg.libX11
      xorg.libxcb
      xorg.libXext
      xorg.libXtst
      xorg.libXfixes
      xorg.libXrandr
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXrender
      xorg.libXcomposite
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbutilrenderutil
      xorg.xcbutilwm
      alsaLib
      wayland
      libxml2
      expat
      glib
      zlib
      krb5
      nspr
      nss
    ];

  runScript = writeScript "binaryninja.sh" ''
  set -e

  # Export environment variables
  export PATH="${python}/bin:$PATH"
  export PYTHONPATH="${python}/lib/python3.12/site-packages:$PYTHONPATH"

  # Run Binary Ninja
  exec "$HOME/.binaryninja/binaryninja" "$@"
  '';

  meta = {
    description = "BinaryNinja";
    platforms = ["x86_64-linux"];
  };
}
