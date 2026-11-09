-- mainframe Neovim colors: greys on black, white for what matters. Applied on top of any colorscheme.
local C = { black = "#050505", panel = "#1c1c1c", dim = "#4a4a4a", mid = "#8c8c8c", text = "#d6d6d6",
            hi = "#f2f2f2", soft = "#bdbdbd" }
local M = {}
function M.apply()
  local set = function(g, o) vim.api.nvim_set_hl(0, g, o) end
  set("LineNr", { fg = C.dim }); set("CursorLineNr", { fg = C.hi, bold = true })
  set("WinSeparator", { fg = C.dim, bg = "none" }); set("NvimTreeWinSeparator", { fg = C.dim, bg = "none" })
  for _, g in ipairs({ "NvimTreeFolderName", "NvimTreeOpenedFolderName", "NvimTreeRootFolder" }) do set(g, { fg = C.hi, bold = true }) end
  set("NvimTreeFolderIcon", { fg = C.soft }); set("NvimTreeIndentMarker", { fg = C.dim }); set("NvimTreeEmptyFolderName", { fg = C.mid })
  set("NvimTreeNormal", { fg = C.text, bg = "none" }); set("NvimTreeNormalNC", { fg = C.text, bg = "none" })
  set("NvimTreeFileIcon", { fg = C.mid }); set("NvimTreeExecFile", { fg = C.hi, bold = true, underline = true }); set("NvimTreeOpenedFile", { fg = C.hi, bold = true })
  set("NvimTreeSpecialFile", { fg = C.soft, underline = true }); set("NvimTreeImageFile", { fg = C.mid })
  set("NvimTreeGitDirty", { fg = C.hi }); set("NvimTreeGitNew", { fg = C.soft }); set("NvimTreeGitDeleted", { fg = C.mid, strikethrough = true })
  set("DevIconLua", { fg = C.soft }); set("DevIconJson", { fg = C.soft }); set("DevIconDefault", { fg = C.mid })
  set("DashboardHeader", { fg = C.hi, bold = true }); set("AlphaButtons", { fg = C.soft }); set("AlphaShortcut", { fg = C.hi, bold = true })
end
local b = { fg = C.text, bg = C.panel }; local c = { fg = C.mid, bg = "none" }
M.lualine = {
  normal = { a = { fg = C.black, bg = C.text, gui = "bold" }, b = b, c = c },
  insert = { a = { fg = C.black, bg = C.hi, gui = "bold" }, b = b, c = c },
  visual = { a = { fg = C.hi, bg = C.dim, gui = "bold" }, b = b, c = c },
  replace = { a = { fg = C.black, bg = C.mid, gui = "bold" }, b = b, c = c },
  command = { a = { fg = C.black, bg = C.soft, gui = "bold" }, b = b, c = c },
  inactive = { a = { fg = C.dim, bg = "none" }, b = { fg = C.dim, bg = "none" }, c = { fg = C.dim, bg = "none" } },
}
return M
