{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # Neovim
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nvim-config-src = {
      url = "github:suprtrtl/neovim/0.12";
      flake = false;
    };

    cheat-cheatsheets = {
      url = "github:cheat/cheatsheets";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        ./hosts/main/configuration.nix
        inputs.home-manager.nixosModules.default
        ./nixos-modules
      ];
    };

    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        ./hosts/vm/configuration.nix
        inputs.home-manager.nixosModules.default
        ./nixos-modules
      ];
    };

    homeManagerModules.default = ./home-manager-modules;

    homeConfigurations.main = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      modules = [
        ./home-manager-modules
      ];
      extraSpecialArgs = {
        inherit inputs;
        system = "x86_64-linux";
      };
    };

    homeConfigurations.wsl = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      modules = [
        ./hosts/wsl/home.nix
        ./home-manager-modules
      ];
      extraSpecialArgs = {inherit inputs;};
    };
  };
}
