{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";  # Uninstall apps not listed
      upgrade = true;
    };

    # Taps
    taps = [
      "homebrew/cask"
      "homebrew/core"
    ];

    # GUI Applications via Homebrew Cask
    casks = [
      # Development Tools
      "cursor"              # AI-powered code editor
      "warp"                # Modern terminal
      "mockoon"             # API mocking tool
      "orbstack"            # Docker/Kubernetes environment

      # Productivity
      "raycast"             # Productivity launcher
      "obsidian"            # Knowledge management (vault: ~/memo)

      # Browsers
      "google-chrome"       # Web browser

      # Communication
      "slack"               # Team communication
      "zoom"                # Video conferencing

      # Security & Utilities
      "bitwarden"           # Password manager GUI

      # Other Tools
      "kindle"              # Kindle reader
    ];

    # Additional formula via Homebrew (for tools better managed via brew)
    brews = [
      # Add any formula that works better via Homebrew than Nix
    ];
  };
}
