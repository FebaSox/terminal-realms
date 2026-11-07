-- bonfire dashboard art for Neovim (alpha-nvim): ruined arch, planted sword, small fire, crescent moon (ruined arch, planted sword, small fire, crescent moon).
-- The fire and embers flicker while the dashboard is open, and stop when you leave it.
local M = {}

M.lines = {
  "                                                     ▄▄   ",
  "   ·               ·      ▄▄▄▄▄▄▄  ▄                  ██▄ ",
  "                     ▄▄███████████       ·            ███ ",
  "                 ▄▄███▀▀▀▀   ▄   ▀▄  ▄              ▄████ ",
  "         ·    ▄▄██▀▀▀        █  ▄ ▀▄             ▀█████▀  ",
  "            ▄██▀▀      ▄     █                            ",
  "            ████          ▀▀▀█▀▀▀                         ",
  "            ████             █    ▀                       ",
  "            ████         ▀   █             ████           ",
  "     ·      ████           ▄█▀██  ▄        ████           ",
  "            ████        █  █▀▀██▄▄█        ████           ",
  "            ████       ████▀████████       ████           ",
  "            ████      ██████████▀████   ▄▄▀▀███  ▄        ",
  " ▄▄▄▄ ▄▄▄▄ ▄███▀▄▄▄▄ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▄ ▄▄██▀█▄█▄▀▄▄▄▄ ▄▄",
  "██████████████████████████████████████████████████████████",
}

M.hl = {
  { { "Ash_moon", 53, 59 } },
  { { "AshStar", 3, 5 }, { "AshStar", 20, 22 }, { "Ash_stone", 28, 49 }, { "Ash_emberD", 51, 54 }, { "Ash_moon", 72, 81 } },
  { { "Ash_emberD", 21, 24 }, { "Ash_stone", 24, 60 }, { "AshStar", 67, 69 }, { "Ash_moon", 81, 90 } },
  { { "Ash_stone", 17, 32 }, { "Ash_stone__stoneL", 32, 35 }, { "Ash_stone", 35, 41 }, { "Ash_stoneL", 41, 44 }, { "Ash_hilt", 47, 50 }, { "Ash_stoneL", 53, 59 }, { "Ash_ember", 61, 64 }, { "Ash_moon", 78, 93 } },
  { { "AshStar", 9, 11 }, { "Ash_stone", 15, 27 }, { "Ash_stone__stoneL", 27, 30 }, { "Ash_stone", 30, 33 }, { "Ash_stoneL", 33, 36 }, { "Ash_hilt", 44, 47 }, { "Ash_emberD", 49, 52 }, { "Ash_stoneL", 53, 59 }, { "Ash_moonD", 72, 81 }, { "Ash_moon", 81, 93 } },
  { { "Ash_stone", 12, 21 }, { "Ash_stone__stoneL", 21, 24 }, { "Ash_stoneL", 24, 27 }, { "Ash_emberD", 33, 36 }, { "Ash_hilt", 41, 44 } },
  { { "Ash_stone", 12, 21 }, { "Ash_stoneL", 21, 24 }, { "Ash_steel", 34, 55 } },
  { { "Ash_stone", 12, 21 }, { "Ash_stoneL", 21, 24 }, { "Ash_steel", 37, 40 }, { "Ash_ember", 44, 47 } },
  { { "Ash_stone", 12, 21 }, { "Ash_stoneL", 21, 24 }, { "Ash_ember", 33, 36 }, { "Ash_f1", 39, 42 }, { "Ash_stoneL", 55, 58 }, { "Ash_stone", 58, 67 } },
  { { "AshStar", 5, 7 }, { "Ash_stone", 13, 22 }, { "Ash_stoneL", 22, 25 }, { "Ash_f1", 36, 42 }, { "Ash_f2__steelL", 42, 45 }, { "Ash_f1", 45, 51 }, { "Ash_f1", 53, 56 }, { "Ash_stoneL", 64, 67 }, { "Ash_stone", 67, 76 } },
  { { "Ash_stone", 12, 21 }, { "Ash_stoneL", 21, 24 }, { "Ash_f1", 32, 35 }, { "Ash_f1", 37, 40 }, { "Ash_f1__f2", 40, 43 }, { "Ash_steelL__f3", 43, 46 }, { "Ash_f2", 46, 49 }, { "Ash_f1", 49, 55 }, { "Ash_f2", 55, 58 }, { "Ash_f1", 58, 61 }, { "Ash_stoneL", 69, 72 }, { "Ash_stone", 72, 81 } },
  { { "Ash_stone", 12, 21 }, { "Ash_stoneL", 21, 24 }, { "Ash_f1", 31, 37 }, { "Ash_f2", 37, 40 }, { "Ash_f1", 40, 43 }, { "Ash_f1__f3", 43, 46 }, { "Ash_f2", 46, 49 }, { "Ash_f3", 49, 52 }, { "Ash_f2", 52, 55 }, { "Ash_f3", 55, 58 }, { "Ash_f1", 58, 61 }, { "Ash_f2", 61, 64 }, { "Ash_f1", 64, 70 }, { "Ash_stoneL", 77, 80 }, { "Ash_stone", 80, 89 } },
  { { "Ash_stone", 12, 21 }, { "Ash_stoneL", 21, 24 }, { "Ash_f1", 30, 36 }, { "Ash_f2", 36, 45 }, { "Ash_f3", 45, 51 }, { "Ash_f4", 51, 54 }, { "Ash_f3", 54, 60 }, { "Ash_f2__f3", 60, 63 }, { "Ash_f2", 63, 69 }, { "Ash_f1", 69, 75 }, { "Ash_stone", 78, 87 }, { "Ash_stoneL__stone", 87, 90 }, { "Ash_stone", 90, 99 }, { "Ash_stone", 101, 104 } },
  { { "Ash_stone", 1, 13 }, { "Ash_stone", 14, 26 }, { "Ash_stone", 27, 54 }, { "Ash_f1__stone", 55, 61 }, { "Ash_f2__stone", 61, 70 }, { "Ash_f3__stone", 70, 76 }, { "Ash_f4__stone", 76, 85 }, { "Ash_f3__stone", 85, 91 }, { "Ash_f2__stone", 91, 100 }, { "Ash_f1__stone", 100, 106 }, { "Ash_stone", 106, 112 }, { "Ash_stone", 113, 155 }, { "Ash_stone", 156, 162 } },
  { { "Ash_stone", 0, 174 } },
}


-- compact version for short windows (the dashboard picks it when the full art would not fit)
M.small_lines = {
  "             ▄▄▄           ▄ ",
  "         ▄▄▀▀▀▀▀▀         ▄██",
  "      ▄▀▀▀    █  ▀       ▀▀▀ ",
  "      ██     ▀█▀             ",
  "      ██      ▀▄     ███     ",
  "      ██   ▄▀▀█▀██   ███     ",
  " ▄ ▄▄ █▀▄▄▄▀███▀███▄▀▀██▄▄▄ ▄",
}
M.small_hl = {
  { { "Ash_stone", 13, 22 }, { "Ash_moon", 33, 36 } },
  { { "Ash_stone", 9, 15 }, { "Ash_stone__stoneL", 15, 21 }, { "Ash_stone", 21, 33 }, { "Ash_moon", 42, 51 } },
  { { "Ash_stone", 6, 9 }, { "Ash_stone__stoneL", 9, 12 }, { "Ash_stone", 12, 15 }, { "Ash_stoneL", 15, 18 }, { "Ash_hilt", 22, 25 }, { "Ash_stoneL", 27, 30 }, { "Ash_moonD", 37, 40 }, { "Ash_moon", 40, 46 } },
  { { "Ash_stone", 6, 9 }, { "Ash_stoneL", 9, 12 }, { "Ash_steel", 17, 26 } },
  { { "Ash_stone", 6, 9 }, { "Ash_stoneL", 9, 12 }, { "Ash_f1__f2", 18, 21 }, { "Ash_f1", 21, 24 }, { "Ash_stoneL", 29, 32 }, { "Ash_stone", 32, 38 } },
  { { "Ash_stone", 6, 9 }, { "Ash_stoneL", 9, 12 }, { "Ash_f1", 15, 18 }, { "Ash_f1__f2", 18, 21 }, { "Ash_f1__f3", 21, 24 }, { "Ash_f3", 24, 27 }, { "Ash_f2__f3", 27, 30 }, { "Ash_f2", 30, 33 }, { "Ash_f1", 33, 36 }, { "Ash_stoneL", 39, 42 }, { "Ash_stone", 42, 48 } },
  { { "Ash_stone", 1, 4 }, { "Ash_stone", 5, 11 }, { "Ash_stone", 12, 15 }, { "Ash_stoneL__stone", 15, 18 }, { "Ash_stone", 18, 24 }, { "Ash_f1", 24, 27 }, { "Ash_f1__f2", 27, 30 }, { "Ash_f2", 30, 33 }, { "Ash_f3", 33, 36 }, { "Ash_f4", 36, 39 }, { "Ash_f3__f4", 39, 42 }, { "Ash_f3", 42, 45 }, { "Ash_f2", 45, 48 }, { "Ash_f1", 48, 51 }, { "Ash_stone", 51, 57 }, { "Ash_stoneL__stone", 57, 60 }, { "Ash_stone", 60, 75 }, { "Ash_stone", 76, 79 } },
}

local PAL = {
  moon = { 206, 178, 134 },
  moonD = { 150, 124, 92 },
  stone = { 74, 56, 50 },
  stoneL = { 128, 70, 40 },
  steel = { 176, 168, 160 },
  steelL = { 255, 182, 110 },
  hilt = { 120, 88, 52 },
  f1 = { 176, 34, 8 },
  f2 = { 240, 96, 16 },
  f3 = { 255, 190, 60 },
  f4 = { 255, 240, 180 },
  ember = { 255, 150, 40 },
  emberD = { 160, 60, 14 },
}
local COMBOS = { "Ash_f1__f2", "Ash_f1__f3", "Ash_f1__stone", "Ash_f2__f3", "Ash_f2__steelL", "Ash_f2__stone", "Ash_f3__f4", "Ash_f3__stone", "Ash_f4__stone", "Ash_steelL__f3", "Ash_stoneL__stone", "Ash_stone__stoneL" }
local LIVE = { f1 = 0.30, f2 = 0.35, f3 = 0.30, f4 = 0.20, ember = 0.6, emberD = 0.6, stoneL = 0.25, steelL = 0.25 }

local function hex(c, k)
  local function ch(v) v = math.floor(v * k + 0.5); if v < 0 then v = 0 elseif v > 255 then v = 255 end; return v end
  return string.format("#%02x%02x%02x", ch(c[1]), ch(c[2]), ch(c[3]))
end

local gain = {}
local function color(name) return hex(PAL[name], gain[name] or 1) end

function M.apply()
  for name in pairs(PAL) do vim.api.nvim_set_hl(0, "Ash_" .. name, { fg = color(name) }) end
  for _, g in ipairs(COMBOS) do
    local a, b = g:match("^Ash_(.-)__(.+)$")
    vim.api.nvim_set_hl(0, g, { fg = color(a), bg = color(b) })
  end
  vim.api.nvim_set_hl(0, "AshStar", { fg = "#6e645f" })
end

local QUOTES = {
  "Praise the sun!", "Don't you dare go hollow.", "Fear not, the dark, my friend.", "Amazing chest ahead.",
  "Be wary of ambush.", "Try jumping.", "Time for jolly cooperation!", "Rest at the bonfire, then roll again.",
  "Git gud.", "Only one ember away from a fresh start.", "Light the fire. Keep the flame.",
  "Hold fast. The next bonfire is close.",
}
M.quote_mark = "\u{2020}"
function M.quote()
  math.randomseed(os.time())
  return QUOTES[math.random(#QUOTES)]
end
function M.menu_colors()
  vim.api.nvim_set_hl(0, "AlphaMenuDescription", { fg = "#ff5f1f" })
  vim.api.nvim_set_hl(0, "AlphaMenuShortcut", { fg = "#e60000", bold = true })
  vim.api.nvim_set_hl(0, "AlphaQuote", { fg = "#cc6a3a", italic = true })
end

local timer
local function alpha_visible()
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if vim.bo[vim.api.nvim_win_get_buf(w)].filetype == "alpha" then return true end
  end
  return false
end

function M.stop()
  if timer then timer:stop(); timer:close(); timer = nil end
  gain = {}; M.apply()
end

function M.start()
  M.apply()
  if timer then return end
  local uv = vim.uv or vim.loop
  local t0 = uv.hrtime()
  timer = uv.new_timer()
  timer:start(0, 110, vim.schedule_wrap(function()
    if not alpha_visible() then return M.stop() end
    local t = (uv.hrtime() - t0) / 1e9
    local base = 0.88 + 0.12 * math.sin(t * 7.1) * math.sin(t * 2.3)
    for name, amt in pairs(LIVE) do
      gain[name] = 1 + amt * (base - 0.88) * 4 + (math.random() - 0.5) * amt * 0.5
    end
    gain.emberD = 0.6 + 0.6 * math.abs(math.sin(t * 1.7))
    M.apply()
  end))
end

function M.setup()
  M.apply()
  vim.schedule(M.menu_colors)
  vim.api.nvim_create_autocmd("ColorScheme", { callback = M.apply })
  vim.api.nvim_create_autocmd("User", { pattern = "AlphaReady", callback = M.start })
  vim.api.nvim_create_autocmd("FileType", { pattern = "alpha", callback = function() vim.schedule(M.start) end })
end

return M
