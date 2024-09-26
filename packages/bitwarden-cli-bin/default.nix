{ lib, stdenv, fetchzip }: stdenv.mkDerivation rec {

  pname = "bitwarden-cli-bin";
  version = "2024.8.2";

  src = fetchzip {
    url = "https://github.com/bitwarden/clients/releases/download/cli-v${version}/bw-macos-${version}.zip";
    hash = "sha256-obJVIJ2n5lEXsjn7RQ+lIraHnBcn4vsU6LaAV4NPBSU=";
  };

  doCheck = true;
  dontStrip = true;

  installPhase = ''
  mkdir -p $out/bin
  cp -rv $src/bw $out/bin/bw
  '';

  meta = with lib; {
    description = "Secure and free password manager for all of your devices";
    homepage = "https://bitwarden.com";
    license = lib.licenses.gpl3Only;
    mainProgram = "bw";
    platforms = platforms.darwin;
  };
}
