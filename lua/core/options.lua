local opt = vim.opt

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = false
vim.g.nvim_gp_typography = "apple"

opt.termguicolors = true
opt.background = "light"
opt.guifont = "SF Mono:h15,Menlo:h14,JetBrainsMono Nerd Font:h14"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.updatetime = 250
opt.timeoutlen = 400
opt.ttimeoutlen = 20
opt.hidden = true
opt.confirm = true
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.backup = false
opt.writebackup = true
opt.autoread = true
opt.history = 2000

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:1"
opt.cursorline = true
opt.colorcolumn = "100"
opt.fillchars = {
  eob = " ",
  fold = " ",
  foldopen = "-",
  foldsep = " ",
  foldclose = "+",
  diff = "/",
}
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true
opt.showmode = false
opt.laststatus = 3
opt.splitright = true
opt.splitbelow = true
opt.pumheight = 12
opt.winminwidth = 5
opt.cmdheight = 1

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
opt.breakindent = true
opt.shiftround = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.grepprg = "rg --vimgrep --smart-case --hidden"
opt.grepformat = "%f:%l:%c:%m"

opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append({ c = true, I = true })
opt.sessionoptions = { "buffers", "curdir", "folds", "help", "tabpages", "winsize", "terminal", "globals" }

vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
