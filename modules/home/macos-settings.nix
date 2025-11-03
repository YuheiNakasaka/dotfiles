{ config, lib, pkgs, ... }:

{
  # Home Manager activation scripts for macOS-specific settings
  # These settings are applied as the user (not root), using the `defaults` command
  home.activation.macosSettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Applying macOS user-specific settings..."

    # ===== Trackpad Settings =====
    # Advanced trackpad settings not supported by nix-darwin trackpad option

    # Corner secondary click (2 = right-bottom corner)
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2

    # Scrolling
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadScroll -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadHorizScroll -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadMomentumScroll -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadScroll -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadHorizScroll -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadMomentumScroll -bool true

    # Gestures
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3

    # Additional trackpad settings
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadHandResting -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad ActuateDetents -bool true
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad FirstClickThreshold -int 1
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad SecondClickThreshold -int 1
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadHandResting -bool true

    # ===== Keyboard Settings =====

    # Set function key behavior (0 = function keys, 1 = media keys)
    $DRY_RUN_CMD /usr/bin/defaults write com.apple.HIToolbox AppleFnUsageType -int 0

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
    $DRY_RUN_CMD /usr/bin/defaults -currentHost delete -g com.apple.keyboard.modifiermapping.0-0-0 2>/dev/null || true

    # Set new modifier mappings
    $DRY_RUN_CMD /usr/bin/defaults -currentHost write -g com.apple.keyboard.modifiermapping.0-0-0 -array \
      '<dict>
        <key>HIDKeyboardModifierMappingSrc</key>
        <integer>30064771129</integer>
        <key>HIDKeyboardModifierMappingDst</key>
        <integer>30064771303</integer>
      </dict>'

    echo "✅ macOS user-specific settings applied successfully!"

    # Note: Input sources (ABC + Japanese) need to be configured manually in System Preferences
  '';
}
