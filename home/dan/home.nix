{ config, pkgs, ... }:

{
  home.username = "dan";
  home.homeDirectory = "/home/dan";
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    userName = "Dan Kenerson";
    userEmail = "contact@dankenerson.com";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      sybau = "echo *akward silence*";
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
  home.file.".config/hypr".source = ./config/hypr;

  home.pointerCursor = {
    name = "macOS";
    size = 24;
    package = pkgs.apple-cursor;
    hyprcursor.enable = true;
    gtk.enable = true;
    x11.enable = true;
  };
}
