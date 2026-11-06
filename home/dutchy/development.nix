{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dotnet-sdk_10
    jdk25
    nodejs
    bun
    pnpm
    playwright-driver.browsers
    claude-code
  ];
}
