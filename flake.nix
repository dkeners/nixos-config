{
  description = "Dan's super awesome NixOS configurations and dotfiles.";

  nixConfig = {
    extra-substituters = ["https://cache.soopy.moe"];
    extra-trusted-public-keys = ["cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # San Francisco Fonts | Apple Fonts
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    nvf.url = "github:notashelf/nvf";
    # Stuff for mac
    # nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-hardware.url = "github:soopyc/nixos-hardware/apple-t2-updates";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      apple-fonts,
      nvf,
      nixos-hardware,
      ...
    }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.dan =
                { pkgs, ... }:
                {
                  imports = [
                    nvf.homeManagerModules.default
                    ./home/dan/home.nix
                  ];
                };

              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
            };
          }
        ];
        specialArgs = { inherit apple-fonts; };
      };
      nixosConfigurations.mbp = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/mbp/configuration.nix
          nixos-hardware.nixosModules.apple-t2
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.dan =
                { pkgs, ... }:
                {
                  imports = [
                    nvf.homeManagerModules.default
                    ./home/dan/home.nix
                  ];
                };

              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
            };
          }
        ];
        specialArgs = { inherit apple-fonts; };
      };
    };
}
