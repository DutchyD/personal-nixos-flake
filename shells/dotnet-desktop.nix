{ pkgs }:

let
  dotnetSdk = pkgs.dotnet-sdk_10;
in
pkgs.mkShell {
  packages = [ dotnetSdk ];

  DOTNET_ROOT = "${dotnetSdk}/share/dotnet";

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (
    with pkgs;
    [
      alsa-lib
      fontconfig
      icu
      libGL
      libICE
      libSM
      libX11
      libXcursor
      libXext
      libXfixes
      libXi
      libXrandr
      libpulseaudio
    ]
  );
}
