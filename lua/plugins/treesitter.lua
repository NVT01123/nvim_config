return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter", -- Sets main module to use for opts
	-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
	opts = {
		ensure_installed = {
			"c",
			"cpp",
			"lua",
			"python",
			"javascript",
			"typescript",
			"vimdoc",
			"vim",
			"regex",
			"terraform",
			"sql",
			"dockerfile",
			"toml",
			"json",
			"java",
			"groovy",
			"go",
			"gitignore",
			"graphql",
			"yaml",
			"make",
			"cmake",
			"markdown",
			"markdown_inline",
			"bash",
			"tsx",
			"css",
			"html",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
		-- incremental_selection = {
		--   enable = true, -- Kích hoạt chọn block code
		--   keymaps = {
		--     init_selection = "gnn", -- Bắt đầu chọn
		--     node_incremental = "grn", -- Mở rộng vùng chọn
		--     node_decremental = "grm", -- Thu nhỏ vùng chọn
		--   },
		-- },
		-- context_commentstring = {
		--   enable = true, -- Tô sáng theo ngữ cảnh
		-- },
	},
}
