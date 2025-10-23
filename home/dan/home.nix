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

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  home.shellAliases = {
    enable = true;
    shellAliases = {
      sybau = "echo *akward silence*";
      rebuild-desktop = "sudo nixos-rebuild switch --flake ~/nixos#desktop";
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
