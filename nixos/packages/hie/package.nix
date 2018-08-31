{ pkgs, stdenv, python, fetchFromGitHub }:
stdenv.mkDerivation rec {
  version = "0.2.2.0";
  name = "haskell-ide-engine-${version}";

  src = fetchFromGitHub {
    rev = "cf08220f56d4692f82b8c44810fbbcb7273bde34";
    repo = "haskell-ide-engine";
    owner = "haskell";
    sha256 = "03z9iffnkzdr6lmsakvk624jk2r7qdbfwn18cmvidh73s2j5gg1l";
    fetchSubmodules = true;

  };
  buildInputs = with pkgs;[
        stack git gnumake
      ];
  patchPhase = ''
  '';

  installPhase = ''
    make build-all

    # install binary
    mkdir -p $out/bin
    
    cp hie $out/bin
    chmod +x $out/bin/hie
    
    cp hie-8.2.1 $out/bin
    chmod +x $out/bin/hie-8.2.1

    cp hie-8.2.2 $out/bin
    chmod +x $out/bin/hie-8.2.2
    
    cp hie-8.4.2 $out/bin
    chmod +x $out/bin/hie-8.4.2

    cp hie-8.4.3 $out/bin
    chmod +x $out/bin/hie-8.4.3
  '';


}
