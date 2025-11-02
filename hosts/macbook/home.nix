{ config, pkgs, userConfig, ... }:

{
  # Import modules
  imports = [
    ../../modules/home/packages.nix
    ../../modules/home/shell.nix
    ../../modules/home/git.nix
  ];

  # Home Manager settings
  home = {
    username = userConfig.username;
    homeDirectory = "/Users/${userConfig.username}";
    stateVersion = "24.11";  # Don't change this

    # Additional files to manage
    file = {
      # Raycast scripts
      ".config/raycast/scripts/start-quicktime-player-screen-record.applescript" = {
        source = ../../config/raycast/start-quicktime-player-screen-record.applescript;
        executable = true;
      };
      ".config/raycast/scripts/open-zatsu-script-with-editor.sh" = {
        source = ../../config/raycast/open-zatsu-script-with-editor.sh;
        executable = true;
      };
      ".config/raycast/scripts/open-memo.sh" = {
        source = ../../config/raycast/open-memo.sh;
        executable = true;
      };

      # Raycast configuration (if needed)
      ".config/raycast/Raycast.rayconfig" = {
        source = ../../config/raycast/Raycast.rayconfig;
      };
    };

    # Session variables
    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Additional programs configuration
  programs = {
    # direnv for per-directory environment
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # fzf for fuzzy finding
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  # XDG Base Directory
  xdg = {
    enable = true;
  };
}
