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
      url = "git+https://codeberg.org/suprtrtl/neovim.git?ref=lazy";
      flake = false;
    };

    cheat-cheatsheets = {
      url = "github:cheat/cheatsheets";
      flake = false;
    };

    zig.url = "github:mitchellh/zig-overlay";
    zig.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    zig,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    # Call zig-overlay for this system
    zigPkgs = zig.packages.${system};

    overlays = [
      (final: prev: {
        zigpkgs = zigPkgs;
      })
    ];

    pkgs = import nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {inherit inputs pkgs;};
      modules = [
        ./hosts/main/configuration.nix
        inputs.home-manager.nixosModules.default
        ./nixos-modules
      ];
    };

    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {inherit inputs pkgs;};
      modules = [
        ./hosts/vm/configuration.nix
        inputs.home-manager.nixosModules.default
        ./nixos-modules
      ];
    };

    homeManagerModules.default = ./home-manager-modules;

    homeConfigurations.main = home-manager.lib.homeManagerConfiguration {
      inherit system pkgs;
      modules = [./home-manager-modules];
      extraSpecialArgs = {
        inherit inputs pkgs system;
      };
    };

    homeConfigurations.wsl = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
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
