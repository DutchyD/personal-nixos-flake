{ pkgs, ... }:

{
  programs.gh.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Dylan de Beer";
        email = "dylan@dylandebeer.nl";
      };
      core.autocrlf = "input";
    };
    ignores = [
      "**/.claude/settings.local.json"
      ".envrc"
      ".direnv/"
    ];
  };

  home.packages = [ pkgs.unzip ];
}
