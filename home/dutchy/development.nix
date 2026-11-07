{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (dotnetCorePackages.combinePackages [
      dotnet-sdk_10
      dotnet-sdk_11
    ])
    jdk25
    nodejs
    bun
    pnpm
    playwright-driver.browsers
    claude-code
  ];
}
