-- the start screen: realm art, a quote, and a few buttons
return {
  "goolord/alpha-nvim", event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", "<cmd>ene<cr>"),
      dashboard.button("SPC ee", "  File tree", "<cmd>NvimTreeToggle<cr>"),
      dashboard.button("SPC ff", "󰱼  Find file", "<cmd>Telescope find_files<cr>"),
      dashboard.button("SPC fs", "  Find text", "<cmd>Telescope live_grep<cr>"),
      dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
    }
    local ok, realms = pcall(require, "terminal_realms")
    if ok then realms.alpha(dashboard) end
    alpha.setup(dashboard.opts)
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
