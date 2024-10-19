{
  lib,
  buildFHSEnv,
  writeScript,
  pkgs,
  python3
}:
buildFHSEnv rec {
  name = "binaryninja";

  python = python3.withPackages (ps: with ps; [
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
    # Create a temporary directory for the symlink
    mkdir -p "$HOME/.binaryninja/libs"
    ln -sf ${python}/lib/libpython3.so "$HOME/.binaryninja/libs/libpython.so"

    # Export environment variables
    export PATH="${python}/bin:$PATH"
    export PYTHONPATH="${python}/lib/python3.12/site-packages:$PYTHONPATH"
    export LD_LIBRARY_PATH="$HOME/.binaryninja/libs:${python}/lib:$LD_LIBRARY_PATH"

    # Run Binary Ninja
    exec "$HOME/.binaryninja/binaryninja" "$@"
  '';

  meta = {
    description = "BinaryNinja";
    platforms = ["x86_64-linux"];
  };
}
