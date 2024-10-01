{
  "image": "mcr.microsoft.com/devcontainers/base:alpine",
  "features": {
    "ghcr.io/devcontainers/features/nix:1": {
      "multiUser": true,
      "version": "latest",
      // Needed for flakes & nix-direnv:
      "extraNixConfig": "experimental-features = nix-command flakes,keep-outputs = true,keep-derivations = true"
    }
  },
  "onCreateCommand": {
    // Set up global gitignore for direnv.
    "init-git": "mkdir -p ~/.config/git && printf '.direnv/\\n.envrc\\n' > ~/.config/git/ignore && git config --global core.excludesfile ~/.config/git/ignore",
    // Install, set up and allow direnv in workspace.
    "install-direnv": "nix profile install nixpkgs#direnv nixpkgs#nix-direnv && mkdir -p ~/.config/direnv && echo 'source $HOME/.nix-profile/share/nix-direnv/direnvrc' >> ~/.config/direnv/direnvrc && cp .envrc.recommended .envrc && direnv allow",
    // Run `print-dev-env` to build `devShells.${system}.default`.
    "build-dev-env": "nix print-dev-env > /dev/null"
  },
  "customizations": {
    "vscode": {
      "extensions": [
        // Inject direnv variables into VS Code terminals and tasks:
        "mkhl.direnv",
        // Support for `.nix` files:
        "jnoortheen.nix-ide"
      ]
    }
  }
}
