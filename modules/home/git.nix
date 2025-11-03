{ config, pkgs, userConfig, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        email = userConfig.email;
        name = userConfig.fullName;
      };

      alias = {
        st = "status";
        co = "checkout";
        lg = "log --stat";
        df = "diff -w";
        cm = "commit";
        br = "branch";
      };
    };

    # Git LFS
    lfs.enable = true;

    # Extra configuration
    extraConfig = {
      core = {
        quotepath = false;  # Display Japanese filenames correctly
      };

      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };

      # Additional useful settings
      init = {
        defaultBranch = "main";
      };

      pull = {
        rebase = false;
      };
    };
  };
}
