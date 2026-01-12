{ 
  description = "Dan's super awesome NixOS configurations and dotfiles."; 

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # San Francisco Fonts | Apple Fonts
    apple-fonts.url= "github:Lyndeno/apple-fonts.nix";
    nvf.url = "github:notashelf/nvf";
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { nixpkgs, home-manager, apple-fonts, nvf, nixos-hardware, ... }: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	  ./hosts/desktop/configuration.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager = {
	      users.dan = { pkgs, ... }: {
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
	      users.dan = { pkgs, ... }: {
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
