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
    # Note: More complex modifier key mappings are configured below using activationScripts
    # remapCapsLockToControl = true;  # Uncomment if you want Caps Lock as Control (alternative to below)
  };

  # Additional keyboard and trackpad settings via activation scripts
  # These settings are applied using defaults command since nix-darwin doesn't support them directly
  system.activationScripts.extraUserActivation.text = ''
    # ===== Trackpad Settings =====
    # Advanced trackpad settings not supported by nix-darwin trackpad option

    # Corner secondary click (2 = right-bottom corner)
    defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2

    # Scrolling
    defaults write com.apple.AppleMultitouchTrackpad TrackpadScroll -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadHorizScroll -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadMomentumScroll -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadScroll -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadHorizScroll -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadMomentumScroll -bool true

    # Gestures
    defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
    defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
    defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
    defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3

    # Additional trackpad settings
    defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -bool true
    defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
    defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1
    defaults write com.apple.AppleMultitouchTrackpad TrackpadHandResting -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad ActuateDetents -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad FirstClickThreshold -int 1
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad SecondClickThreshold -int 1
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadHandResting -bool true

    # ===== Keyboard Settings =====

    # Set function key behavior (0 = function keys, 1 = media keys)
    defaults write com.apple.HIToolbox AppleFnUsageType -int 0

    # Modifier key mappings for internal keyboard (VendorID=0, ProductID=0)
    # Current mapping: Caps Lock (0x700000039) → Command (0x7000000E7)
    #
    # Common modifier key codes:
    # - 0x700000039: Caps Lock
    # - 0x7000000E0: Left Control
    # - 0x7000000E1: Left Shift
    # - 0x7000000E2: Left Option (Alt)
    # - 0x7000000E3: Left Command
    # - 0x7000000E4: Right Control
    # - 0x7000000E5: Right Shift
    # - 0x7000000E6: Right Option (Alt)
    # - 0x7000000E7: Right Command
    #
    # To change the mapping, modify the integer values below:
    # Example: To map Caps Lock to Control, change Dst to 30064771296 (Left Control)

    # Remove existing modifier mappings for internal keyboard
    defaults -currentHost delete -g com.apple.keyboard.modifiermapping.0-0-0 2>/dev/null || true

    # Set new modifier mappings
    defaults -currentHost write -g com.apple.keyboard.modifiermapping.0-0-0 -array \
      '<dict>
        <key>HIDKeyboardModifierMappingSrc</key>
        <integer>30064771129</integer>
        <key>HIDKeyboardModifierMappingDst</key>
        <integer>30064771303</integer>
      </dict>'

    # Configure input sources (ABC + Japanese)
    # Note: This is managed by macOS and may need manual setup in System Preferences
    # The following input sources are enabled:
    # - ABC (English keyboard layout)
    # - Japanese (Romaji input method)
  '';
}
