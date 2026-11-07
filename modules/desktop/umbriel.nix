{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.custom.desktop == "umbriel") {
    programs.umbriel.enable = true;

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };

    services.displayManager.noctalia-greeter.enable = true;

    # The kde platform theme reads the noctalia color scheme Noctalia writes to kdeglobals.
    qt = {
      enable = true;
      platformTheme = "kde";
      style = "breeze";
    };

    environment.systemPackages = [
      pkgs.kitty
      pkgs.kdePackages.kwallet
      pkgs.kdePackages.dolphin
      pkgs.kdePackages.kio-extras
      pkgs.kdePackages.ffmpegthumbs
      pkgs.kdePackages.kdegraphics-thumbnailers
    ];

    # Without a Plasma session, KService finds no applications menu and Dolphin's "Open With" stays empty.
    environment.etc."xdg/menus/applications.menu".source =
      "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

    xdg.mime.defaultApplications."inode/directory" = "org.kde.dolphin.desktop";

    services.dbus.packages = [ pkgs.kdePackages.kwallet ];

    security.pam.services.login.kwallet = {
      enable = true;
      package = pkgs.kdePackages.kwallet-pam;
    };

    # kwallet-pam's autostart entry sets X-systemd-skip, so the XDG autostart generator ignores it.
    systemd.user.services.kwallet-pam-init = {
      description = "Unlock KWallet from PAM credentials";
      wantedBy = [ "umbriel-session.target" ];
      after = [ "umbriel-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init";
        Slice = "background.slice";
        Restart = "no";
      };
    };
  };
}
