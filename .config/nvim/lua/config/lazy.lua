-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("config.plugins")
--require("lazy").setup({
--	-- LSP
--	{
--	  	"VonHeikemen/lsp-zero.nvim", branch = "v3.x",
--		dependencies = {
--		  -- LSP Support
--			{"neovim/nvim-lspconfig"},
--			{"williamboman/mason.nvim"},
--			{"williamboman/mason-lspconfig.nvim"},
--
--			-- Autocompletion
--			{"hrsh7th/nvim-cmp"},
--			--{"hrsh7th/cmp-buffer"},
--			--{"hrsh7th/cmp-path"},
--			--{"saadparwaiz1/cmp_luasnip"},
--			{"hrsh7th/cmp-nvim-lsp"},
--			--{"hrsh7th/cmp-nvim-lua"},
--
--			-- Snippets
--			{"L3MON4D3/LuaSnip"},
--			-- Snippet Collection (Optional)
--			--{"rafamadriz/friendly-snippets"},
--		}
--	},
--
--    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
--
--	{"catppuccin/nvim", name = "catppuccin", priority = 1000},
--    {"nvim-lualine/lualine.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}},
--
--    "lewis6991/gitsigns.nvim",
--})
