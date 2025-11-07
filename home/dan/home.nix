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

  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

        theme = {
          enable = true;
          name = "onedark";
          style = "dark";
        };

        statusline.lualine = {
          enable = true;
          theme = "onedark";
        };
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        lsp = {
          enable = true;
        };

        languages  = {
          enableTreesitter = true;

          nix.enable = true;
          rust.enable = true;
          csharp.enable = true;
          php.enable = true;
          ts.enable = true;
          html.enable = true;
          markdown.enable = true;
        };
      };
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
  home.file.".config/btop/btop.conf".source = ./config/btop/btop.conf;
  home.file.".config/waybar".source = ./config/waybar;

  home.pointerCursor = {
    name = "macOS";
    size = 24;
    package = pkgs.apple-cursor;
    hyprcursor.enable = true;
    gtk.enable = true;
    x11.enable = true;
  };

  services.swww.enable = true;
}
