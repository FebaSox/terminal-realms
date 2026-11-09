return {
  { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = { { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file" },
             { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Find text" },
             { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" } } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = "BufReadPre",
    main = "nvim-treesitter.configs",
    opts = { highlight = { enable = true }, indent = { enable = true }, auto_install = true,
             ensure_installed = { "lua", "bash", "json", "markdown", "python", "javascript", "html", "css", "sql", "kdl" } } },
}
