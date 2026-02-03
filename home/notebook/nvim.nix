{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    extraPackages = with pkgs; [
      ripgrep
      lazygit
      fd
      gcc
      nodejs
      tree-sitter

      solargraph
      elixir-ls
			lua-language-server
    ];

    globals.mapleader = " ";

    keymaps = [
      { key = "<leader>e"; action = "<cmd>Vex<CR>"; }
      { key = "<C-s>"; action = "<cmd>:w!<CR>"; }

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


      { key = "<leader>nh"; action = "<cmd>Gitsigns next_hunk<CR>"; }
    ];

    opts = {
      number = true;
      relativenumber = true;
      scrolloff = 8;
      sidescrolloff = 8;
      autoindent = true;
      clipboard = "unnamedplus";
      ts = 2;
      sw = 2;
      undofile = true;
      completeopt = "longest,menuone";
      encoding = "utf-8";
      fileencoding = "utf-8";
      foldmethod = "expr";
      foldlevelstart = 99;
      termguicolors = true;
    };

    colorschemes.gruvbox.enable = true;

    plugins = {
			diffview-nvim.enable = true;
      gitsigns.enable = true;
      fzf-lua = {
        enable = true;
        settings = {
          winopts = {
            height = 0.40;
            width = 1.00;
            row = 1.00;
            col = 0.00;
            border = "none";
            fullscreen = false;
          };
          fzf_opts = {
            "--layout" = "reverse-list";
          };
        };
      };
      bufferline.enable = true;
      lualine.enable = true;
      diffview.enable = true;

      lsp = {
        enable = true;
        servers = {
          rust_analyzer.enable = true;
          elixirls.enable = true;
          solargraph = {
            enable = true;
            cmd = [ "solargraph" ];
            filetypes = [ "ruby" "eruby" ];
            rootMarkers = [
              "Gemfile"
              "Rakefile"
            ];
          };
          ts_ls.enable = true;
          eslint.enable = true;
          nil_ls.enable = true;
          lua_ls.enable = true;
        };
      };

      treesitter = {
        enable = true;
        nixGrammars = true;
        folding.enable = true;
        highlight.enable = true;
        indent.enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          ruby
          elixir
          heex
          eex
          html
          css
          javascript
          typescript
          json
          yaml
          markdown
          markdown_inline
          lua
          vim
          vimdoc
          bash
          sql
          dockerfile
          gitignore
          regex
          toml
          xml
          nix
        ];
      };
    };

    plugins.cmp = {
      enable = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-e>" = "cmp.mapping.close()";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
      };
    };

    extraConfigLua = ''
      local lsp = vim.lsp

      local signs = {
        Error = "✗",
        Warn = "⚠",
        Hint = "💡",
        Info = "ℹ"
      }

      lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

      lsp.handlers["textDocument/signatureHelp"] = lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      for _, server in pairs(vim.lsp.get_clients()) do
        server.server_capabilities = vim.tbl_deep_extend('force', server.server_capabilities, capabilities)
      end

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.rb",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.ex",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.heex",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ruby",
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.expandtab = true
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "elixir",
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.expandtab = true
        end,
      })
    '';
  };
}
