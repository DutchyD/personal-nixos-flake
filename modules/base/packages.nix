{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nano
    git
  ];
}
