-- frost Neovim colors: icy blue, dusky snow, lantern amber. Applied on top of any colorscheme.
local C = {
  navy = "#0a0f1a", panel = "#141d30", slate = "#3b4a63", snow = "#c8d3e6", ice = "#9cc4f0",
  ice2 = "#8fb0e8", amber = "#f0b45a", teal = "#6fd0c0", violet = "#a090e0", red = "#d0605e",
}
local M = {}
function M.apply()
  local set = function(g, o) vim.api.nvim_set_hl(0, g, o) end
  set("LineNr", { fg = C.slate }); set("CursorLineNr", { fg = C.amber, bold = true })
  set("WinSeparator", { fg = C.slate, bg = "none" }); set("NvimTreeWinSeparator", { fg = C.slate, bg = "none" })
  for _, g in ipairs({ "NvimTreeFolderName", "NvimTreeOpenedFolderName", "NvimTreeRootFolder" }) do set(g, { fg = C.ice, bold = true }) end
  set("NvimTreeFolderIcon", { fg = C.ice }); set("NvimTreeIndentMarker", { fg = C.slate }); set("NvimTreeEmptyFolderName", { fg = C.ice2 })
  set("NvimTreeNormal", { fg = C.snow, bg = "none" }); set("NvimTreeNormalNC", { fg = C.snow, bg = "none" })
  set("NvimTreeFileIcon", { fg = C.ice2 }); set("NvimTreeExecFile", { fg = C.amber, bold = true }); set("NvimTreeOpenedFile", { fg = C.amber, bold = true })
  set("NvimTreeSpecialFile", { fg = C.teal, underline = true }); set("NvimTreeImageFile", { fg = C.ice2 })
  set("NvimTreeGitDirty", { fg = C.amber }); set("NvimTreeGitNew", { fg = C.teal }); set("NvimTreeGitDeleted", { fg = C.red })
  set("DevIconLua", { fg = C.ice2 }); set("DevIconJson", { fg = C.amber }); set("DevIconDefault", { fg = C.ice2 })
  set("DashboardHeader", { fg = C.ice, bold = true }); set("AlphaButtons", { fg = C.ice2 }); set("AlphaShortcut", { fg = C.amber, bold = true })
end
local b = { fg = C.ice, bg = C.panel }; local c = { fg = C.snow, bg = "none" }
M.lualine = {
  normal = { a = { fg = C.navy, bg = C.ice, gui = "bold" }, b = b, c = c },
  insert = { a = { fg = C.navy, bg = C.amber, gui = "bold" }, b = b, c = c },
  visual = { a = { fg = C.navy, bg = C.violet, gui = "bold" }, b = b, c = c },
  replace = { a = { fg = C.navy, bg = C.red, gui = "bold" }, b = b, c = c },
  command = { a = { fg = C.navy, bg = C.teal, gui = "bold" }, b = b, c = c },
  inactive = { a = { fg = C.slate, bg = "none" }, b = { fg = C.slate, bg = "none" }, c = { fg = C.slate, bg = "none" } },
}
return M
