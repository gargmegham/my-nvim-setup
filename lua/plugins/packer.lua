local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'tpope/vim-fugitive'
	use 'navarasu/onedark.nvim'
	use 'neovim/nvim-lspconfig'
	use 'mbbill/undotree'
	use 'WhoIsSethDaniel/mason-tool-installer.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}
	use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
	use 'stevearc/conform.nvim'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
	use 'famiu/bufdelete.nvim'
	use 'akinsho/bufferline.nvim'
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons',
		},
	}
	if packer_bootstrap then
		require('packer').sync()
	end
end)
