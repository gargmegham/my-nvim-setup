local bufferline = require('bufferline')
bufferline.setup({
	options = {
		persist_buffer_sort = true,
		hover = {
			enabled = true,
			delay = 200,
			reveal = {'close'}
		},
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				separator = true,
			}
		}
	}
})
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map('n', '<S-Left>', '<cmd>BufferLineCyclePrev<cr>', opts)
map('n', '<S-Right>', '<cmd>BufferLineCycleNext<cr>', opts)
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', opts)
map('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', opts)
