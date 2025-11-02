{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Version Control
    gh              # GitHub CLI
    git             # Git version control
    git-lfs         # Git Large File Storage

    # Development Tools
    jq              # JSON processor
    pre-commit      # Git hook management
    # openapi-generator  # OpenAPI code generator

    # Search and Filter
    ripgrep         # Fast text search (rg)
    peco            # Interactive filtering tool

    # File Management
    tree            # Directory structure visualization

    # Media Processing
    ffmpeg          # Video/audio processing
    imagemagick     # Image processing
    graphviz        # Graph visualization

    # JavaScript Runtime
    bun             # Fast JavaScript runtime (if needed on host)

    # Security
    bitwarden-cli   # Bitwarden password manager CLI
    mitmproxy       # HTTP/HTTPS proxy for testing
  ];
}
