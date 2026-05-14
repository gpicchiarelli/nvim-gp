vim.bo.commentstring = "; %s"
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.textwidth = 100

vim.keymap.set("n", "<localleader>c", "<cmd>CLIPSCheck<cr>", { buffer = true, desc = "CLIPS check" })
vim.keymap.set("n", "<localleader>r", "<cmd>CLIPSEsegui<cr>", { buffer = true, desc = "CLIPS esegui" })
vim.keymap.set("n", "<localleader>l", "<cmd>CLIPSCarica<cr>", { buffer = true, desc = "CLIPS carica" })
