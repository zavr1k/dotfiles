return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup({
            options = {
                theme = "dracula",
                component_separators = '|',
                section_separators = '',
                ignore_focus = {'neo-tree'},
                disabled_filetypes = {
                  statusline = {'neo-tree'},
                },
            },
            sections = {
                lualine_a = {'buffers'},
            },
            disabled_buftypes = {"neo-tree"},
        })
    end
}
