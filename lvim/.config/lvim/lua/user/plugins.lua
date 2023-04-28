lvim.plugins = {
  { "tpope/vim-surround" },
  { "lunarvim/horizon.nvim" },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath "state" .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize" }
      })
    end
  },
  { "theprimeagen/harpoon" },
  { "mbbill/undotree" }
}
