{ config, pkgs, userConfig, ... }:

{
  # Import modules
  imports = [
    ../../modules/system/defaults.nix
    ../../modules/system/homebrew.nix
  ];

  # System-wide packages
  environment.systemPackages = with pkgs; [
    vim
    curl
    wget
  ];

  # Nix configuration
  nix = {
    package = pkgs.nix;
    optimise.automatic = true;

    settings = {
      # Enable flakes and nix-command
      experimental-features = [ "nix-command" "flakes" ];

      # Trusted users
      trusted-users = [ "@admin" userConfig.username ];
    };

    # Garbage collection
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;  # Sunday
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };

  # System state version
  system.stateVersion = 4;

  # ids.gids.nixbld = 350;

  # User configuration
  system.primaryUser = userConfig.username;
  users.users.${userConfig.username} = {
    name = userConfig.username;
    home = "/Users/${userConfig.username}";
    shell = pkgs.zsh;
  };

  # Programs
  programs = {
    zsh.enable = true;
  };

  # Font configuration
  fonts = {
    packages = with pkgs; [
      # Add fonts here if needed
      # noto-fonts
      # noto-fonts-cjk
      # noto-fonts-emoji
    ];
  };

  # Security
  security.pam.services.sudo_local.touchIdAuth = true;  # Enable Touch ID for sudo
}
