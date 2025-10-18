{ 
  description = "Dan's super awesome NixOS configurations and dotfiles."; 

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	  ./hosts/desktop/configuration.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager = {
	      users.dan = import ./home/dan/home.nix;
	      useGlobalPkgs = true;
	      useUserPackages = true;
	      backupFileExtension = "backup";
	    };
	  }
      ];
    };
  };
}
