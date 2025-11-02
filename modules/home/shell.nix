{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    # Shell options
    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
      share = true;           # Share history between terminals
      ignoreDups = true;      # Ignore duplicate commands
    };

    # Environment variables
    sessionVariables = {
      LANG = "ja_JP.UTF-8";

      # AWS
      AWS_ROLE = "PowerUserAccess";

      # Source secrets from separate file (managed by Bitwarden)
      # Secrets will be loaded from ~/.secrets if it exists
    };

    # Shell initialization
    initContent = ''
      # Prompt
      export PS1="%~ $ "

      # Add custom bin to PATH
      export PATH="$HOME/bin:$PATH"

      # Colors
      autoload -Uz colors
      colors

      # Completion
      autoload -Uz compinit
      compinit
      zstyle ':completion:*:default' menu select=1
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' matcher-list ''' 'm:{a-z}={A-Z} r:|[-_.]=**' '+m:{A-Z}={a-z} r:|[-_.]=**'

      # Command correction
      setopt correct

      # Key bindings
      stty erase '^?'
      stty erase ^H
      bindkey "^[[3~" delete-char

      # peco: incremental history search
      function peco-select-history() {
          local tac
          if which tac > /dev/null; then
              tac="tac"
          else
              tac="tail -r"
          fi
          BUFFER=$(\\history -n 1 | \\
              eval $tac | \\
              peco --query "$LBUFFER")
          CURSOR=$#BUFFER
          zle clear-screen
      }
      zle -N peco-select-history
      bindkey '^r' peco-select-history

      # peco: SSH host selection
      alias ssh-peco='ssh $(grep -w Host ~/.ssh/config | awk '\''{print $2}'\'' | peco)'

      # Source secrets file if it exists (managed by Bitwarden)
      if [ -f "$HOME/.secrets" ]; then
        source "$HOME/.secrets"
      fi

      # ghcup (Haskell toolchain) if installed
      [ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
    '';

    # Aliases
    shellAliases = {
      ll = "ls -la";
    };

    # Completions for additional tools
    completionInit = ''
      # Add deno completions to search path if exists
      if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then
        export FPATH="$HOME/.zsh/completions:$FPATH"
      fi
    '';
  };
}
