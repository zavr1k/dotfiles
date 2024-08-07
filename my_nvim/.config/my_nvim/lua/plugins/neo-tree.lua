return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", {})
        vim.keymap.set("n", "<leader>E", ":Neotree reveal_force_cwd<CR>", {})
        require("neo-tree").setup({
            window = {
                width = 30,
                mappings = {
                    ["o"] = "open",
                }
            }
        })
    end
}
