vim.g.mapleader = " "

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.modifiable = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.number = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.foldmethod = "expr"
vim.opt.foldlevelstart = 99
vim.opt.termguicolors = true
vim.opt.updatetime = 300
vim.opt.background = "dark"
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.number = true
vim.o.mouse = "a"
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.path='**'
vim.g.transparent_enabled = true

vim.cmd.colorscheme 'retrobox'

vim.diagnostic.config({ signs = false})

-- Basic keymaps 
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-s>', '<cmd>:w!<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window'})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window'})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window'})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window'})
vim.keymap.set('n', '<leader>q',   ':bd<CR>', {})

vim.keymap.set('n', '<leader>e', '<cmd>:Oil<CR>', {})

vim.keymap.set('n', '<leader>ff', ':FzfLua files<CR>', {})
vim.keymap.set('n', '<leader>fg', ':FzfLua grep_project<CR>', {})
vim.keymap.set('n', '<leader>gs', ':FzfLua git_status<CR>', {})

vim.keymap.set('n', '<S-h>', ':bprev<CR>', {})
vim.keymap.set('n', '<S-l>', ':bnext<CR>', {})

vim.keymap.set('n', '<A-j>', '<cmd>m .+1<CR>==', {})
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<CR>==', {})
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", {})
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", {})

vim.keymap.set('n', '<leader>gb', ":Gitsigns toggle_current_line_blame<CR>")
vim.keymap.set('n', '<leader>gB', ":Gitsigns blame<CR>")
vim.keymap.set('n', ']c', ":Gitsigns next_hunk<CR>")
vim.keymap.set('n', '[c', ":Gitsigns prev_hunk<CR>")

-- Basic Autocommands
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Plugin manager
local function gh(repo)
	return 'https://github.com/' .. repo
end

vim.pack.add { gh('lewis6991/gitsigns.nvim') }
vim.pack.add { gh('ibhagwan/fzf-lua') }
vim.pack.add { gh 'j-hui/fidget.nvim' }
vim.pack.add { gh('stevearc/oil.nvim')}
vim.pack.add {
	gh 'neovim/nvim-lspconfig',
	gh 'mason-org/mason.nvim',
	gh 'mason-org/mason-lspconfig.nvim',
	gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}
vim.pack.add {
	gh 'neovim/nvim-lspconfig',
	gh  'hrsh7th/nvim-cmp',
	gh	'williamboman/mason.nvim',
	gh	'williamboman/mason-lspconfig.nvim',
	gh	'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh  'hrsh7th/cmp-buffer',
  gh  'hrsh7th/cmp-path',
  gh  'hrsh7th/cmp-nvim-lsp',
  gh  'hrsh7th/cmp-nvim-lua',
  gh  'ray-x/cmp-treesitter',
  gh  'L3MON4D3/LuaSnip',
  gh  'saadparwaiz1/cmp_luasnip',
}
vim.pack.add { gh('MeanderingProgrammer/render-markdown.nvim') }
vim.pack.add { gh('emrearmagan/atlas.nvim')}
vim.pack.add {
  gh 'ej-shafran/compile-mode.nvim',
  gh 'nvim-lua/plenary.nvim'
}
vim.pack.add { gh('nvim-orgmode/orgmode')}

require('orgmode').setup({
  org_agenda_files = '~/orgfiles/**/*',
  org_default_notes_file = '~/orgfiles/refile.org',
})

require('fidget').setup {}
require('oil').setup({
	columns = {
		"permissions",
		"size",
		"mtime"
	},
	skip_confirm_for_simple_edits = true
})
require('fzf-lua').setup({
	winopts = {
		height = 0.40,
		width = 1.00,
		row = 1.00,
		col = 0.00,
		border = "rounded",
		fullscreen = false,
	},
	fzf_opts = {
		["--layout"] = "reverse-list",
	},
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noselect",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lua" },
    { name = "treesitter" },
  }),
})
--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("<leader>co", function()
      vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end, "code [o]rganize imports")

    map("K", vim.lsp.buf.hover, "Hover Documentation")

    map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    map("gr", function() require("fzf-lua").lsp_references() end, "[G]oto [R]eferences")
    map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame Symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup =
      vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = function()
          vim.lsp.buf.document_highlight()
          vim.diagnostic.open_float(nil, { scope = "cursor" })
        end,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, "Toggle inlay [h]ints")
    end
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

local servers = {
  -- ruff = {},
  pyright = {},
  -- htmx = {},
  bashls = {},
  rust_analyzer = {},
  -- rubocop = {},
  solargraph = {
    cmd = {
      'env',
      '-u', 'GEM_PATH',
      '-u', 'RUBYLIB',
      'bundle',
      'exec',
      'solargraph',
      'stdio',
    },
    filetypes = { 'ruby' },
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local matches = vim.fs.find({ 'Gemfile' }, { upward = true, limit = 2, path = fname })
      local child_or_root_path, maybe_umbrella_path = unpack(matches)
      local root_dir = vim.fs.dirname(maybe_umbrella_path or child_or_root_path)

      on_dir(root_dir)
    end,
  },
  cssls = {},
  elixirls = {
    cmd = { 'elixir-ls' },
    filetypes = { 'elixir', 'eelixir', 'heex', 'surface'},
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      --- Elixir workspaces may have multiple `mix.exs` files, for an "umbrella" layout or monorepo.
      --- So we specify `limit=2` and treat the highest one (if any) as the root of an umbrella app.
      local matches = vim.fs.find({ 'mix.exs' }, { upward = true, limit = 2, path = fname })
      local child_or_root_path, maybe_umbrella_path = unpack(matches)
      local root_dir = vim.fs.dirname(maybe_umbrella_path or child_or_root_path)

      on_dir(root_dir)
    end,
  },
  biome = { filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
  ts_ls = {
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    -- TODO: this is not working yet for typescript
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  eslint = { filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
  tailwindcss = {},
  html = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        hint = { enable = true },
        diagnostics = {
          enable = true,
          globals = {
            "vim",
            "describe",
            "it",
            "before_each",
            "after_each",
            "packer_plugins",
            "MiniTest",
          },
          disable = { "missing-fields", "lowercase-global" },
        },
      },
    },
  },
}

require("mason").setup({
  ui = {
    border = vim.o.winborder,
  },
})

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  "stylua", -- Used to format Lua code
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      require("lspconfig")[server_name].setup(server)
    end,
  },
  automatic_installation = false
})


vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

-- Ensure basic parsers are installed
local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'ruby', 'rust', 'zig', 'elixir' }
require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
	-- Check if a parser exists and load it
	if not vim.treesitter.language.add(language) then return end
	-- Enable syntax highlighting and other treesitter features
	vim.treesitter.start(buf, language)

	-- Enable treesitter based folds
	-- For more info on folds see `:help folds`
	-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	-- vim.wo.foldmethod = 'expr'

	-- Check if treesitter indentation is available for this language, and if so enable it
	-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
	local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

	-- Enable treesitter based indentation
	if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
	callback = function(args)
		local buf, filetype = args.buf, args.match

		local language = vim.treesitter.language.get_lang(filetype)
		if not language then return end

		local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

		if vim.tbl_contains(installed_parsers, language) then
			-- Enable the parser if it is already installed
			treesitter_try_attach(buf, language)
		elseif vim.tbl_contains(available_parsers, language) then
			-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
			require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
		else
			-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
			treesitter_try_attach(buf, language)
		end
	end,
})

vim.cmd [[ 
  highlight Normal guibg=black
]]
--------------- CUSTOM THEME ---------------------------------
local c = {
  bg_dark    = "#101010",
  bg         = "#181818",
  bg1        = "#282828",
  bg2        = "#453d41",
  bg3        = "#484848",
  bg4        = "#52494e",
  fg         = "#e4e4ef",
  fg1        = "#f4f4ff",
  fg2        = "#f5f5f5",
  white      = "#ffffff",
  black      = "#000000",
  red_dim    = "#c73c3f",
  red        = "#f43841",
  red_bright = "#ff4f58",
  green      = "#73c936",
  yellow     = "#ffdd33",
  brown      = "#cc8c3c",
  quartz     = "#95a99f",
  niagara_d  = "#5f627f",
  niagara    = "#96a6c8",
  wisteria   = "#9e95c7",
  none       = "NONE",
}

local config_hightlights = {
  transparent = false,
  italics = {
    comments  = true,
    keywords  = false,
    functions = false,
    strings   = false,
    variables = false,
  },
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hi("Normal",        { fg = c.fg,       bg = c.bg })
hi("NormalFloat",   { fg = c.fg,       bg = c.bg1 })
hi("NormalNC",      { fg = c.fg,       bg = c.bg })
hi("EndOfBuffer",   { fg = c.bg1,      bg = c.none })
hi("ColorColumn",   { bg = c.bg1 })
hi("Conceal",       { fg = c.niagara_d })
hi("Cursor",        { fg = c.bg,       bg = c.yellow })
hi("CursorIM",      { fg = c.bg,       bg = c.yellow })
hi("CursorColumn",  { bg = c.bg1 })
hi("CursorLine",    { bg = c.bg1 })
hi("CursorLineNr",  { fg = c.yellow,   bg = c.bg1,    bold = true })
hi("Directory",     { fg = c.niagara })
hi("DiffAdd",       { fg = c.green,    bg = c.bg1,    bold = true })
hi("DiffChange",    { fg = c.yellow,   bg = c.bg1 })
hi("DiffDelete",    { fg = c.red,      bg = c.bg1 })
hi("DiffText",      { fg = c.yellow,   bg = c.bg2,    bold = true })
hi("ErrorMsg",      { fg = c.red,      bg = c.bg,     bold = true })
hi("WinSeparator",  { fg = c.bg4,      bg = c.bg })
hi("VertSplit",     { fg = c.bg4,      bg = c.bg })
hi("Folded",        { fg = c.brown,    bg = c.bg1 })
hi("FoldColumn",    { fg = c.niagara_d, bg = c.bg })
hi("SignColumn",    { fg = c.fg,       bg = c.bg })
hi("LineNr",        { fg = c.bg4,      bg = c.bg })
hi("MatchParen",    { fg = c.yellow,   bg = c.bg4,    bold = true })
hi("ModeMsg",       { fg = c.yellow,   bold = true })
hi("MoreMsg",       { fg = c.green,    bold = true })
hi("NonText",       { fg = c.bg1 })
hi("Pmenu",         { fg = c.fg,       bg = c.bg1 })
hi("PmenuSel",      { fg = c.fg1,      bg = c.bg4 })
hi("PmenuSbar",     { bg = c.bg2 })
hi("PmenuThumb",    { bg = c.bg4 })
hi("Question",      { fg = c.green })
hi("QuickFixLine",  { fg = c.yellow,   bold = true })
hi("Search",        { fg = c.bg,       bg = c.yellow })
hi("IncSearch",     { fg = c.bg,       bg = c.red_bright, bold = true })
hi("CurSearch",     { fg = c.bg,       bg = c.red_bright, bold = true })
hi("SpecialKey",    { fg = c.niagara_d })
hi("SpellBad",      { undercurl = true, sp = c.red })
hi("SpellCap",      { undercurl = true, sp = c.yellow })
hi("SpellLocal",    { undercurl = true, sp = c.green })
hi("SpellRare",     { undercurl = true, sp = c.wisteria })
hi("StatusLine",    { fg = c.fg,       bg = c.bg1 })
hi("StatusLineNC",  { fg = c.bg4,      bg = c.bg1 })
hi("Substitute",    { fg = c.bg,       bg = c.yellow })
hi("TabLine",       { fg = c.fg,       bg = c.bg1 })
hi("TabLineFill",   { bg = c.bg_dark })
hi("TabLineSel",    { fg = c.yellow,   bg = c.bg,     bold = true })
hi("Title",         { fg = c.yellow,   bold = true })
hi("Visual",        { bg = c.bg4 })
hi("VisualNOS",     { bg = c.bg4 })
hi("WarningMsg",    { fg = c.yellow })
hi("Whitespace",    { fg = c.bg1 })
hi("WildMenu",      { fg = c.yellow,   bg = c.bg2,    bold = true })
hi("WinBar",        { fg = c.fg,       bg = c.bg1 })
hi("WinBarNC",      { fg = c.bg4,      bg = c.bg1 })

-- ── Syntax (classic highlight groups) ──────────────────────────────
hi("Comment",       { fg = c.brown,    italic = config_hightlights.italics.comments })
hi("Constant",      { fg = c.wisteria })
hi("String",        { fg = c.green })
hi("Character",     { fg = c.green })
hi("Number",        { fg = c.wisteria })
hi("Boolean",       { fg = c.yellow,   bold = true })
hi("Float",         { fg = c.wisteria })
hi("Identifier",    { fg = c.niagara })
hi("Function",      { fg = c.quartz })
hi("Statement",     { fg = c.yellow,   bold = true })
hi("Conditional",   { fg = c.yellow,   bold = true })
hi("Repeat",        { fg = c.yellow,   bold = true })
hi("Label",         { fg = c.yellow,   bold = true })
hi("Operator",      { fg = c.fg1 })
hi("Keyword",       { fg = c.yellow,   bold = true })
hi("Exception",     { fg = c.red_bright, bold = true })
hi("PreProc",       { fg = c.quartz })
hi("Include",       { fg = c.niagara })
hi("Define",        { fg = c.niagara })
hi("Macro",         { fg = c.quartz })
hi("PreCondit",     { fg = c.quartz })
hi("Type",          { fg = c.yellow,   bold = true })
hi("StorageClass",  { fg = c.yellow,   bold = true })
hi("Structure",     { fg = c.niagara })
hi("Typedef",       { fg = c.yellow,   bold = true })
hi("Special",       { fg = c.quartz })
hi("SpecialChar",   { fg = c.green })
hi("Tag",           { fg = c.yellow })
hi("Delimiter",     { fg = c.fg })
hi("SpecialComment",{ fg = c.brown,    bold = true })
hi("Debug",         { fg = c.red_bright })
hi("Underlined",    { underline = true })
hi("Ignore",        { fg = c.bg4 })
hi("Error",         { fg = c.red,      bold = true })
hi("Todo",          { fg = c.yellow,   bg = c.bg1,    bold = true, italic = true })

-- ── Treesitter ─────────────────────────────────────────────────────
hi("@variable",              { fg = c.fg })
hi("@variable.builtin",      { fg = c.niagara })
hi("@variable.parameter",    { fg = c.niagara })
hi("@variable.member",       { fg = c.niagara })
hi("@constant",              { fg = c.wisteria })
hi("@constant.builtin",      { fg = c.yellow,   bold = true })
hi("@constant.macro",        { fg = c.quartz })
hi("@string",                { fg = c.green })
hi("@string.escape",         { fg = c.quartz })
hi("@string.special",        { fg = c.quartz })
hi("@string.regexp",         { fg = c.quartz })
hi("@character",             { fg = c.green })
hi("@number",                { fg = c.wisteria })
hi("@number.float",          { fg = c.wisteria })
hi("@boolean",               { fg = c.yellow,   bold = true })
hi("@type",                  { fg = c.niagara })
hi("@type.builtin",          { fg = c.yellow,   bold = true })
hi("@type.qualifier",        { fg = c.yellow,   bold = true })
hi("@type.definition",       { fg = c.niagara })
hi("@function",              { fg = c.quartz })
hi("@function.builtin",      { fg = c.yellow })
hi("@function.macro",        { fg = c.quartz })
hi("@function.method",       { fg = c.quartz })
hi("@function.method.call",  { fg = c.quartz })
hi("@constructor",           { fg = c.niagara })
hi("@keyword",               { fg = c.yellow,   bold = true })
hi("@keyword.function",      { fg = c.yellow,   bold = true })
hi("@keyword.operator",      { fg = c.yellow,   bold = true })
hi("@keyword.return",        { fg = c.yellow,   bold = true })
hi("@keyword.import",        { fg = c.niagara })
hi("@keyword.conditional",   { fg = c.yellow,   bold = true })
hi("@keyword.repeat",        { fg = c.yellow,   bold = true })
hi("@keyword.exception",     { fg = c.red_bright, bold = true })
hi("@keyword.directive",     { fg = c.quartz })
hi("@operator",              { fg = c.fg1 })
hi("@punctuation.bracket",   { fg = c.fg })
hi("@punctuation.delimiter", { fg = c.fg })
hi("@punctuation.special",   { fg = c.quartz })
hi("@comment",               { fg = c.brown,    italic = config_hightlights.italics.comments })
hi("@comment.todo",          { fg = c.yellow,   bg = c.bg1, bold = true, italic = true })
hi("@comment.error",         { fg = c.red,      bold = true })
hi("@comment.warning",       { fg = c.yellow,   bold = true })
hi("@comment.note",          { fg = c.niagara,  bold = true })
hi("@label",                 { fg = c.yellow })
hi("@namespace",             { fg = c.niagara })
hi("@module",                { fg = c.niagara })
hi("@attribute",             { fg = c.quartz })
hi("@property",              { fg = c.niagara })
hi("@field",                 { fg = c.niagara })
hi("@tag",                   { fg = c.yellow })
hi("@tag.attribute",         { fg = c.niagara })
hi("@tag.delimiter",         { fg = c.fg })
hi("@markup.strong",         { bold = true })
hi("@markup.italic",         { italic = true })
hi("@markup.underline",      { underline = true })
hi("@markup.strikethrough",  { strikethrough = true })
hi("@markup.heading",        { fg = c.yellow,   bold = true })
hi("@markup.link",           { fg = c.niagara,  underline = true })
hi("@markup.link.url",       { fg = c.green,    underline = true })
hi("@markup.raw",            { fg = c.green })
hi("@markup.list",           { fg = c.yellow })
hi("@diff.plus",             { fg = c.green })
hi("@diff.minus",            { fg = c.red })
hi("@diff.delta",            { fg = c.yellow })

-- ── LSP semantic tokens ────────────────────────────────────────────
hi("@lsp.type.class",        { fg = c.niagara })
hi("@lsp.type.decorator",    { fg = c.quartz })
hi("@lsp.type.enum",         { fg = c.niagara })
hi("@lsp.type.enumMember",   { fg = c.wisteria })
hi("@lsp.type.function",     { fg = c.quartz })
hi("@lsp.type.interface",    { fg = c.niagara })
hi("@lsp.type.macro",        { fg = c.quartz })
hi("@lsp.type.method",       { fg = c.quartz })
hi("@lsp.type.namespace",    { fg = c.niagara })
hi("@lsp.type.parameter",    { fg = c.niagara })
hi("@lsp.type.property",     { fg = c.niagara })
hi("@lsp.type.struct",       { fg = c.niagara })
hi("@lsp.type.type",         { fg = c.niagara })
hi("@lsp.type.typeParameter",{ fg = c.niagara, italic = true })
hi("@lsp.type.variable",     { fg = c.fg })
hi("@lsp.mod.deprecated",    { strikethrough = true })

-- ── LSP diagnostics ────────────────────────────────────────────────
hi("DiagnosticError",        { fg = c.red })
hi("DiagnosticWarn",         { fg = c.yellow })
hi("DiagnosticInfo",         { fg = c.niagara })
hi("DiagnosticHint",         { fg = c.wisteria })
hi("DiagnosticOk",           { fg = c.green })
hi("DiagnosticVirtualTextError",  { fg = c.red,      italic = true })
hi("DiagnosticVirtualTextWarn",   { fg = c.yellow,   italic = true })
hi("DiagnosticVirtualTextInfo",   { fg = c.niagara,  italic = true })
hi("DiagnosticVirtualTextHint",   { fg = c.wisteria, italic = true })
hi("DiagnosticUnderlineError",    { undercurl = true, sp = c.red })
hi("DiagnosticUnderlineWarn",     { undercurl = true, sp = c.yellow })
hi("DiagnosticUnderlineInfo",     { undercurl = true, sp = c.niagara })
hi("DiagnosticUnderlineHint",     { undercurl = true, sp = c.wisteria })
hi("DiagnosticSignError",         { fg = c.red })
hi("DiagnosticSignWarn",          { fg = c.yellow })
hi("DiagnosticSignInfo",          { fg = c.niagara })
hi("DiagnosticSignHint",          { fg = c.wisteria })
hi("DiagnosticFloatingError",     { fg = c.red })
hi("DiagnosticFloatingWarn",      { fg = c.yellow })
hi("LspReferenceText",            { bg = c.bg2 })
hi("LspReferenceRead",            { bg = c.bg2 })
hi("LspReferenceWrite",           { bg = c.bg2,  bold = true })
hi("LspInlayHint",                { fg = c.niagara_d, italic = true })
hi("LspSignatureActiveParameter", { fg = c.yellow, bold = true })

-- ── nvim-cmp ───────────────────────────────────────────────────────
hi("CmpItemAbbr",          { fg = c.fg })
hi("CmpItemAbbrMatch",     { fg = c.yellow,  bold = true })
hi("CmpItemAbbrMatchFuzzy",{ fg = c.yellow })
hi("CmpItemKind",          { fg = c.quartz })
hi("CmpItemMenu",          { fg = c.brown,   italic = true })
hi("CmpItemKindText",      { fg = c.fg })
hi("CmpItemKindMethod",    { fg = c.quartz })
hi("CmpItemKindFunction",  { fg = c.quartz })
hi("CmpItemKindField",     { fg = c.niagara })
hi("CmpItemKindVariable",  { fg = c.fg })
hi("CmpItemKindClass",     { fg = c.niagara })
hi("CmpItemKindInterface", { fg = c.niagara })
hi("CmpItemKindModule",    { fg = c.niagara })
hi("CmpItemKindProperty",  { fg = c.niagara })
hi("CmpItemKindKeyword",   { fg = c.yellow,  bold = true })
hi("CmpItemKindSnippet",   { fg = c.green })
hi("CmpItemKindValue",     { fg = c.wisteria })
hi("CmpItemKindEnum",      { fg = c.niagara })
hi("CmpItemKindColor",     { fg = c.quartz })
hi("CmpItemKindConstant",  { fg = c.wisteria })
hi("CmpItemKindEnumMember",{ fg = c.wisteria })
hi("CmpItemKindStruct",    { fg = c.niagara })
hi("CmpItemKindEvent",     { fg = c.red_bright })
hi("CmpItemKindOperator",  { fg = c.fg1 })
hi("CmpItemKindTypeParameter", { fg = c.niagara })

-- ── GitSigns ───────────────────────────────────────────────────────
hi("GitSignsAdd",    { fg = c.green })
hi("GitSignsChange", { fg = c.yellow })
hi("GitSignsDelete", { fg = c.red })

-- ── Indent-blankline ───────────────────────────────────────────────
hi("IblIndent",     { fg = c.bg1 })
hi("IblScope",      { fg = c.bg2 })

-- ── Notify ─────────────────────────────────────────────────────────
hi("NotifyERRORBorder", { fg = c.red })
hi("NotifyWARNBorder",  { fg = c.yellow })
hi("NotifyINFOBorder",  { fg = c.niagara })
hi("NotifyDEBUGBorder", { fg = c.bg4 })
hi("NotifyTRACEBorder", { fg = c.wisteria })
hi("NotifyERRORIcon",   { fg = c.red })
hi("NotifyWARNIcon",    { fg = c.yellow })
hi("NotifyINFOIcon",    { fg = c.niagara })
hi("NotifyERRORTitle",  { fg = c.red,      bold = true })
hi("NotifyWARNTitle",   { fg = c.yellow,   bold = true })
hi("NotifyINFOTitle",   { fg = c.niagara,  bold = true })

-- ── Treesitter context ─────────────────────────────────────────────
hi("TreesitterContext",       { bg = c.bg1 })
hi("TreesitterContextBottom", { underline = true, sp = c.bg4 })

-- ── Mason ──────────────────────────────────────────────────────────
hi("MasonNormal",          { fg = c.fg,      bg = c.bg1 })
hi("MasonHeader",          { fg = c.bg,      bg = c.yellow, bold = true })
hi("MasonHeaderSecondary", { fg = c.bg,      bg = c.niagara, bold = true })
hi("MasonHighlight",       { fg = c.yellow })
hi("MasonHighlightSecondary", { fg = c.green })
hi("MasonMuted",           { fg = c.bg4 })
hi("MasonMutedBlock",      { fg = c.bg4,     bg = c.bg2 })

-- ── Markdown (built-in) ────────────────────────────────────────────
hi("markdownH1",        { fg = c.yellow,  bold = true })
hi("markdownH2",        { fg = c.yellow,  bold = true })
hi("markdownH3",        { fg = c.niagara, bold = true })
hi("markdownH4",        { fg = c.niagara })
hi("markdownCode",      { fg = c.green })
hi("markdownCodeBlock", { fg = c.green })
hi("markdownLink",      { fg = c.niagara, underline = true })
hi("markdownUrl",       { fg = c.green,   underline = true })
hi("markdownBold",      { bold = true })
hi("markdownItalic",    { italic = true })
