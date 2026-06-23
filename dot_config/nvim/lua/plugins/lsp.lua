return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Completion capabilities (broadcast to every server via the "*" config).
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", { capabilities = capabilities })

			-- Per-server overrides. These merge on top of the defaults that
			-- mason-lspconfig supplies for each installed server.
			vim.lsp.config("pyright", {
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							autoImportCompletions = true,
							diagnosticSeverityOverrides = {
								reportMissingImports = "warning",
							},
						},
					},
				},
			})

			vim.lsp.config("ruff", {
				init_options = {
					settings = {
						organizeImports = true,
						fixableRules = { "F401", "F841" },
					},
				},
			})

			-- mason-lspconfig v2: installs the listed servers and, with
			-- automatic_enable = true (default), enables every installed
			-- server via vim.lsp.enable() — including elixirls.
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"rust_analyzer",
					"pyright",
					"ruff",
					"elixirls",
				},
			})

			-- Keymaps + format-on-save, wired up when any server attaches.
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local bufnr = event.buf
					local opts = { buffer = bufnr, remap = false }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
					vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method("textDocument/formatting") then
						local group = vim.api.nvim_create_augroup("lsp_autoformat", { clear = false })
						vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							group = group,
							desc = "LSP format on save",
							callback = function()
								vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
							end,
						})
					end
				end,
			})
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
			})
		end,
	},
}
