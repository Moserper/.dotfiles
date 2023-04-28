local builtin = require('telescope.builtin')

local default = {
  layout_strategy = "horizontal",
  layout_config = {
    height = 0.8,
    width = 0.8,
  },
}

lvim.builtin.telescope.pickers.find_files = default
lvim.builtin.telescope.pickers.live_grep = default
lvim.builtin.telescope.pickers.grep_string = default

vim.keymap.set('n', '<leader>pf', builtin.find_files)
vim.keymap.set('n', '<C-p>', builtin.git_files)
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
-- vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
