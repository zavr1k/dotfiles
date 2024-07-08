vim.cmd("set number")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.opt.swapfile = false

vim.keymap.set("n", "<c-k>", ":wincmd k<cr>")
vim.keymap.set("n", "<c-j>", ":wincmd j<cr>")
vim.keymap.set("n", "<c-h>", ":wincmd h<cr>")
vim.keymap.set("n", "<c-l>", ":wincmd l<cr>")
vim.keymap.set("n", "<leader>q", ":quitall<CR>")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "habamax" } },
	-- checker = { enabled = true },
})
