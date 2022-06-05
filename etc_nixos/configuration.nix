# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.kernelParams = [ "mem_sleep_default=deep" ];
  boot.cleanTmpDir = true;

  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;

  hardware.firmware = with pkgs; [
    (callPackage ./qca6174_firmware.nix {})
  ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "idris"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  #networking.interfaces.enp0s20f0u1u2.useDHCP = true;
  networking.interfaces.wlp1s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus32";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Australia/Sydney";


  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    onboard 
    udiskie
    htop
    networkmanager
    networkmanager_dmenu
    networkmanagerapplet

    wget feh
    zip unzip gzip bzip2
    killall coreutils
    zsh
 
    vim emacs neovim
    kitty
    git

    arandr

    # N.B. icon theme needed for xournalpp
    gnome3.adwaita-icon-theme

    firefox chromium qutebrowser
    megasync
    xournal xournalpp
    write_stylus
    i3pystatus

    # pdf stuf
    mupdf pdftk qpdfview zathura

    gimp
    inkscape

    python3

    tetex

    # N.B. qt5 is needed for Write to work
    qt5.full

  ];

  fonts.fonts = with pkgs; [
  fira-code
  fira-code-symbols
  source-code-pro
  hack-font
  ];


  # control the backlight
  programs.light.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.libinput.tapping = true;
  services.xserver.libinput.naturalScrolling = true;

  services.xserver.enableCtrlAltBackspace = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.greeters.enso.enable = true;
  services.xserver.desktopManager.default  = "none";
  services.xserver.windowManager.i3.enable = true;

  services.xserver.xkbOptions = "caps:super, ctrl:swap_lalt_lctl";

  services.redshift = {
    enable = true;
  };
  location.latitude = 33.87;
  location.longitude = 151.21;

  # "video" is needed to be able to change backligt
  users.users.alexei = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video"]; 
  };

  services.emacs.enable = true;


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}

