-- Set default indentation to 4 spaces
vim.opt.tabstop = 4        -- number of visual spaces per TAB
vim.opt.shiftwidth = 4     -- spaces used for each step of (auto)indent
vim.opt.softtabstop = 4    -- number of spaces a <Tab> counts for while editing
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.smartindent = true -- automatically insert indents in some cases
vim.opt.autoindent = true  -- copy indent from current line when starting a new one

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus" -- always use the system clipboard

-- netrw settings
vim.g.netrw_liststyle = 3 -- for tree view
