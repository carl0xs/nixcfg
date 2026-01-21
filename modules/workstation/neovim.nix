{ config, pkgs, inputs, ... }:

let
  # Nixvim-based neovim (available as 'nvim-nix')
  nvim-nixvim = inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
    pkgs = pkgs;
    module = {
      package = pkgs.neovim-unwrapped;
      extraPackages = with pkgs; [
        ripgrep
        lazygit
      ];

      globals.mapleader = " ";
      keymaps = [
        { key = "<leader>e"; action = "<cmd>Vex<CR>"; }
        { key = "C-s"; action = "<cmd>:w!<CR>"; }

        { key = "[b"; action = "<cmd>bprevious<CR>"; }
        { key = "]b"; action = "<cmd>bnext<CR>"; }

        { key = "<S-h>"; action = "<cmd>bprev<CR>"; }
        { key = "<S-l>"; action = "<cmd>bnext<CR>"; }
        { key = "<C-q>"; action = "<cmd>bd<CR>"; }
        { key = "<leader>vs"; action = "<cmd>vsplit<CR>"; }

        { key = "<leader>ff"; action = "<cmd>FzfLua files<CR>"; }
        { key = "<leader>fg"; action = "<cmd>FzfLua grep_project<CR>"; }
        { key = "<leader>gs"; action = "<cmd>FzfLua git_status<CR>"; }
        { key = "<leader>gb"; action = "<cmd>Gitsigns toggle_current_line_blame<CR>"; }
      ];

      # Options
      opts = {
        number = true;
        relativenumber = true;
        scrolloff = 8;
        sidescrolloff = 8;
      };

      # Colorscheme
      colorschemes.gruvbox.enable = true;

      # Plugins
      plugins = {
        gitsigns.enable = true;
        fzf-lua.enable = true;
        bufferline.enable = true;
        # LSP
        lsp = {
          enable = true;
          servers = {
            rust_analyzer.enable = true;
            elixirls.enable = true;
            solargraph.enable = true;
            ts_ls.enable = true;
            eslint.enable = true;
            nil_ls.enable = true;
            lua_ls.enable = true;
          };
        };
        treesitter = {
          enable = true;
        };
      };
    };
  };

  # Wrapper to run nixvim as 'nvim-nix'
  nvim-nix = pkgs.writeShellScriptBin "nvim-nix" ''
    exec ${nvim-nixvim}/bin/nvim "$@"
  '';
in
{
  environment.systemPackages = [
    pkgs.neovim
    nvim-nix
  ];
}
