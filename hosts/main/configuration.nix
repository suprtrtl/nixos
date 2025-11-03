{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.systemd-boot.editor = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.iwd.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Driverss
  hardware.enableRedistributableFirmware = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # services.displayManager.ly.enable = true;

  services.smartd.enable = true;
  services.smartd.devices = [
    {
      device = "/dev/disk/by-id/nvme-SAMSUNG_MZALQ512HALU-000L2_S4UKNX0R685928";
    }
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
      ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          Privacy = "device";
          JustWorksRepairing = "always";
          Class = "0x000100";
          FastConnectable = "true";
        };
      };
    };
  };

  services.blueman.enable = true;
  hardware.xpadneo.enable = true;
  boot = {
    extraModprobeConfig = ''
      options bluetooth disable_ertm=Y
    '';
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Powerbutton
  services.logind.settings.Login = {
    HandlePowerKey = "suspend";
  };

  # Fingerprint
  fingerprint.enable = true;

  # enables external packages
  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Hyprland
  hyprland.enable = true;

  # Niri
  niri.enable = true;

  spotify.enable = true;

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  users.users.suprtrtl = {
    isNormalUser = true;
    description = "suprtrtl";
    extraGroups = ["networkmanager" "wheel" "bluetooth" "dialout" "uucp"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "suprtrtl" = {
        imports = [
          ./home.nix
          inputs.self.outputs.homeManagerModules.default
        ];
      };
    };

    backupFileExtension = "bak";
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Install zsh
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    lynx
    mono
    nyxt # Not Very Performant Currently
    protonup-qt # Add to steam.nix
    protontricks # Add to steam.nix

    qutebrowser
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
