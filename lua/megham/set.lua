-- Create a local alias for vim.opt to keep code concise
local opt = vim.opt

-- Enable line numbers
opt.number = true

-- Enable relative line numbers (except for the current line, which stays absolute)
opt.relativenumber = true

-- Enable mouse support (allows using the mouse in all modes)
opt.mouse = "a"

-- Enable automatic indentation (inherits indentation from the previous line)
opt.autoindent = true

-- Set tab width to 4 spaces
opt.tabstop = 4

-- Set soft tab width to 4 spaces (controls tab behavior when using the Tab key)
opt.softtabstop = 4

-- Set indentation width to 4 spaces (controls how much indentation shifts when using >> or <<)
opt.shiftwidth = 4

-- Enable smart tab behavior (makes Tab respect indentation settings)
opt.smarttab = true

-- Disable highlighted search matches (keeps matches from being highlighted after search)
vim.opt.hlsearch = false

-- Enable incremental search (highlights matches while typing the search query)
vim.opt.incsearch = true

-- Set file encoding to UTF-8 (ensures proper handling of Unicode characters)
opt.encoding = "utf-8"

-- Enable visual bell instead of an audible one (avoids annoying beep sounds)
opt.visualbell = true

-- Keep at least 5 lines above/below the cursor when scrolling (prevents the cursor from sticking to edges)
opt.scrolloff = 5

-- Replace the end-of-buffer (~) lines with blank spaces (for a cleaner look)
opt.fillchars = { eob = " " }

-- Enable true color support (only if the terminal supports it)
if vim.fn.has("termguicolors") == 1 then
  opt.termguicolors = true
end
