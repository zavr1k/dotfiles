return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local actions = require "telescope.actions"
        require('telescope').setup{
            defaults = {
                mappings = {
                  i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous
                  }
                },
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = { prompt_position = "top", preview_width = 0.55 },
                    vertical = { mirror = true },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                }
            }
        }
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
}
