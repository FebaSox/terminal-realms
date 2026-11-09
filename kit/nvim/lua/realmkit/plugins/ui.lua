return {
  -- base colors; terminal-realms paints the realm on top
  { "folke/tokyonight.nvim", priority = 1000, config = function()
      require("tokyonight").setup({ style = "night", transparent = true })
      vim.cmd.colorscheme("tokyonight")
    end },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "nvim-lualine/lualine.nvim", event = "VeryLazy",
    opts = { options = { globalstatus = true, section_separators = { left = "", right = "" }, component_separators = "|" } } },
  { "nvim-tree/nvim-tree.lua", cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
    keys = { { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "File tree" },
             { "<leader>ef", "<cmd>NvimTreeFindFileToggle<cr>", desc = "File tree at this file" } },
    opts = { view = { width = 32 }, renderer = { indent_markers = { enable = true } },
             filters = { custom = { ".DS_Store" } }, git = { ignore = false } } },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  { "lewis6991/gitsigns.nvim", event = "BufReadPre", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
}
