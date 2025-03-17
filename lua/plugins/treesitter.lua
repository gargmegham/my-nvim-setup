require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "cpp", "html", "css", "lua", "python", "javascript", "typescript", "bash", "help", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  indent = {
	enable = true,
  },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
	  enable = true,
	  disable = function(lang, buf)
		  if lang == "html" then
			  print("disabled")
			  return true
		  end

		  local max_filesize = 100 * 1024 -- 100 KB
		  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		  if ok and stats and stats.size > max_filesize then
			  vim.notify(
			  "File larger than 100KB treesitter disabled for performance",
			  vim.log.levels.WARN,
			  {title = "Treesitter"}
			  )
			  return true
		  end
	  end,

	  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	  -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
	  -- Using this option may slow down your editor, and you may see some duplicate highlights.
	  -- Instead of true it can also be a list of languages
	  additional_vim_regex_highlighting = { "markdown" },
  },
}
