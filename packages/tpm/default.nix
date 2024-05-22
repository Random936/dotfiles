{ lib, stdenv, fetchFromGitHub }: stdenv.mkDerivation rec {
  pname = "tpm";
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tpm";
    rev = "v${version}";
    hash = "sha256-CeI9Wq6tHqV68woE11lIY4cLoNY8XWyXyMHTDmFKJKI=";
  };

  doCheck = true;

  installPhase = ''
    cp -rv $src/ $out
  '';

  meta = with lib; {
    description = "A tmux package manager. Installs and loads tmux plugins.";
    homepage = "https://github.com/tmux-plugins/tpm";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
