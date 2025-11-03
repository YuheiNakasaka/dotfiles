{ config, pkgs, ... }:

{
  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.5;
      orientation = "bottom";
      tilesize = 48;
      show-recents = false;
      launchanim = false;
      minimize-to-application = true;
      mru-spaces = false;  # Don't rearrange spaces based on most recent use
    };

    # Finder settings
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";  # List view
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
    };

    # Trackpad settings
    # Note: nix-darwin only supports a limited set of trackpad options
    # For more advanced settings, use activationScripts below
    trackpad = {
      # Basic clicking
      Clicking = true;  # Tap to click
      TrackpadRightClick = false;  # Two-finger click/tap for right-click (disabled, using corner instead)
      TrackpadThreeFingerDrag = false;  # Three-finger drag
    };

    # Keyboard settings
    NSGlobalDomain = {
      # Key repeat settings (not set = using macOS defaults)
      # KeyRepeat = 2;  # Commented out to use system default
      # InitialKeyRepeat = 15;  # Commented out to use system default

      # Enable full keyboard access for all controls (not set = using macOS default)
      # AppleKeyboardUIMode = 3;  # Commented out to use system default

      # Auto-correct and text substitution settings (matching current Mac settings)
      # NSAutomaticSpellingCorrectionEnabled = not set (using macOS default)
      NSAutomaticCapitalizationEnabled = true;  # Auto-capitalize
      NSAutomaticPeriodSubstitutionEnabled = true;  # Double-space for period
      # NSAutomaticQuoteSubstitutionEnabled = not set (using macOS default)
      # NSAutomaticDashSubstitutionEnabled = not set (using macOS default)

      # Press and hold for accents (not set = using macOS default, typically true)
      # ApplePressAndHoldEnabled = true;

      # Interface settings
      AppleInterfaceStyle = "Dark";  # Dark mode
      AppleShowAllExtensions = true;

      # Scrolling behavior
      "com.apple.swipescrolldirection" = false;  # Natural scrolling (false = traditional scrolling)

      # Trackpad force click and haptic feedback
      "com.apple.trackpad.forceClick" = false;  # Force click (false = disabled)
    };

    # Screensaver and lock settings
    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 0;
    };

    # Other system settings
    loginwindow = {
      GuestEnabled = false;  # Disable guest account
    };

    # Hot corners (optional - adjust as needed)
    # screencapture.location = "~/Pictures/Screenshots";
  };

  # Keyboard mapping (if needed)
  system.keyboard = {
    enableKeyMapping = true;
    # Note: More complex modifier key mappings are configured in home-manager activation
    # remapCapsLockToControl = true;  # Uncomment if you want Caps Lock as Control (alternative to below)
  };
}
