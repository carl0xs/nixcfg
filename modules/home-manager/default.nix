{ config, pkgs, inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; pkgs = pkgs; };
    backupFileExtension = "hm-bak";
    sharedModules = [
      inputs.nixvim.homeModules.nixvim
      ../fish/default.nix
      ../git/default.nix
      ../nvim/default.nix
      ../tmux/default.nix
    ];
    users.carlos = { pkgs, ... }: {
      home.username = "carlos";
      home.homeDirectory = "/home/carlos";
      home.stateVersion = "25.05";

      home.sessionPath = [
        "$HOME/.npm-global/bin"
        "$HOME/.local/share/pnpm"
      ];

      home.sessionVariables = {
        PNPM_HOME = "$HOME/.local/share/pnpm";
      };

      home.packages = with pkgs; [
        tree
        gnumake
        gcc
        jq
        ripgrep
        fzf
        curl
        rsync
        bat
        lazygit
        direnv
        docker
        docker-compose
        usql
        zoxide
        htop
        fastfetch
        bash-language-server
      ];
    };
  };
}
