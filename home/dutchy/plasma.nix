{
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  config = lib.mkIf (osConfig.custom.desktop == "plasma") {
    home.packages = [ pkgs.nordic ];

    programs.plasma = {
      enable = true;

      workspace.lookAndFeel = "Nordic-darker";

      kwin.virtualDesktops = {
        number = 4;
        rows = 2;
      };

      kscreenlocker.autoLock = false;

      input.mice = [
        {
          name = "Logitech PRO X 2";
          vendorId = "046d";
          productId = "40a9";
          accelerationProfile = "none";
        }
      ];

      configFile.kdeglobals.General = {
        BrowserApplication = "vivaldi-stable.desktop";
        TerminalApplication = "ghostty";
        TerminalService = "com.mitchellh.ghostty.desktop";
      };
    };
  };
}
