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
