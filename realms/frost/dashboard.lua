-- frostart.lua: frost dashboard art (snowy pines, lantern, aurora, crescent moon).
-- The aurora shimmers and the lantern flickers while the dashboard is open.
local M = {}

M.lines = {
  "              ·                ▄▄██▀▀▀████▄▄     ▄        ",
  "▄ ·     ▄▄▄                ▄▄██▀▀██▀▀▀████▀▀███▄█▀     ██▄",
  "▀███▄▄▄▄▀▀▀▀█████     ·  ██▀▀██▀▀▀▀   ▀▀▀▀▀▀█▀ ███      ▀▀",
  "▀███▀▀█████████▀          ▀▀▀ ▀                 ▀███▀    ▀",
  " ▀▀▀▀▀▀▀▀▀▀▀▀▀                             ███            ",
  "     ▄▀▀▀▀▀▀▀▄             ·              ▀███▀           ",
  "    ▄█████████▄  ▄                       ▀▀▀▀▀▀▀          ",
  "    ▄█████████▄ ▀▀▀                 ▄    ▀█████▀   ▄█▄  · ",
  "   ▄▀█████████▀█████       █▀█     ▀█▀  ▀▀▀▀▀▀▀▀▀ ▄███▄   ",
  "  ▄█████████████▀▀▀█       █ █    ▀▀▀▀▀▄▀███████▀▄▄███▄   ",
  "   ██████████████████      █      █████▀▀▀▀▀▀▀▀▀▀▀█████▄  ",
  " ▄▀▀██████████▀▀▀▀▀▀█      █      █▀▀▀█▀▀███████▀▀█████▄  ",
  " ▀▀▀▀▀▀▀▀▀▀▀▀▀███████▄ ▄▄▄▄▀▄▄▄▄▄▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀███████  ",
  "▄▄▄▄▄▄▄▄▀▀▀▀▀▄▄▄▄▀▄▄▀▀▀██████████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▄▄▄▄▄▀▄▄▄▄▀",
  "██████████████████████████████████████████████████████████",
}

M.hl = {
  { { "FrStar", 14, 16 }, { "Fr_a1", 32, 44 }, { "Fr_a1__a2", 44, 53 }, { "Fr_a1", 53, 71 }, { "Fr_moon", 76, 79 } },
  { { "Fr_a1", 0, 3 }, { "FrStar", 4, 6 }, { "Fr_snow", 11, 14 }, { "Fr_snowD", 14, 20 }, { "Fr_a1", 36, 48 }, { "Fr_a1__a2", 48, 54 }, { "Fr_a2", 54, 60 }, { "Fr_a2__a3", 60, 69 }, { "Fr_a2", 69, 81 }, { "Fr_a1__a2", 81, 87 }, { "Fr_a1", 87, 96 }, { "Fr_moon", 96, 105 }, { "Fr_a1", 110, 119 } },
  { { "Fr_a1__a2", 0, 3 }, { "Fr_a1", 3, 21 }, { "Fr_snow", 21, 24 }, { "Fr_snow__pine2", 24, 27 }, { "Fr_snowD__pine", 27, 33 }, { "Fr_a1__snowD", 33, 36 }, { "Fr_a1", 36, 51 }, { "FrStar", 56, 58 }, { "Fr_a1", 60, 66 }, { "Fr_a1__a2", 66, 72 }, { "Fr_a2", 72, 78 }, { "Fr_a2__a3", 78, 84 }, { "Fr_a3", 84, 90 }, { "Fr_a3", 93, 105 }, { "Fr_a2", 105, 117 }, { "Fr_moon", 118, 127 }, { "Fr_a2", 133, 136 }, { "Fr_a1__a2", 136, 139 } },
  { { "Fr_a2__a3", 0, 3 }, { "Fr_a2", 3, 12 }, { "Fr_a1__a2", 12, 18 }, { "Fr_pine2", 18, 27 }, { "Fr_pine", 27, 39 }, { "Fr_a2", 39, 48 }, { "Fr_a2", 58, 67 }, { "Fr_a3", 68, 71 }, { "Fr_moon", 88, 94 }, { "Fr_moonD", 94, 103 }, { "Fr_a2", 107, 110 } },
  { { "Fr_a3", 1, 10 }, { "Fr_a2__a3", 10, 13 }, { "Fr_pine2__a3", 13, 16 }, { "Fr_pine2__snow", 16, 25 }, { "Fr_pine__snowD", 25, 37 }, { "Fr_pine", 37, 40 }, { "Fr_snow", 69, 72 }, { "Fr_snowD", 72, 78 } },
  { { "Fr_snow", 5, 8 }, { "Fr_snow__pine2", 8, 17 }, { "Fr_snowD__pine", 17, 29 }, { "Fr_snowD", 29, 32 }, { "FrStar", 45, 47 }, { "Fr_snow__pine2", 61, 64 }, { "Fr_pine2", 64, 67 }, { "Fr_pine", 67, 73 }, { "Fr_snowD__pine", 73, 76 } },
  { { "Fr_pine2", 4, 19 }, { "Fr_pine", 19, 37 }, { "Fr_snowD", 39, 42 }, { "Fr_pine2", 65, 68 }, { "Fr_pine2__snow", 68, 74 }, { "Fr_pine__snowD", 74, 83 }, { "Fr_pine", 83, 86 } },
  { { "Fr_snow", 4, 19 }, { "Fr_snowD", 19, 37 }, { "Fr_snow__pine2", 38, 41 }, { "Fr_snowD__pine", 41, 47 }, { "Fr_snowD", 64, 67 }, { "Fr_snow__pine2", 71, 74 }, { "Fr_pine2", 74, 80 }, { "Fr_pine", 80, 89 }, { "Fr_snowD__pine", 89, 92 }, { "Fr_snow", 95, 98 }, { "Fr_snowD", 98, 104 }, { "FrStar", 106, 108 } },
  { { "Fr_pine2", 3, 6 }, { "Fr_snow__pine2", 6, 9 }, { "Fr_pine2", 9, 21 }, { "Fr_pine", 21, 36 }, { "Fr_snowD__pine", 36, 39 }, { "Fr_pine2", 39, 45 }, { "Fr_pine", 45, 54 }, { "Fr_post", 61, 70 }, { "Fr_snow__pine2", 75, 78 }, { "Fr_pine", 78, 81 }, { "Fr_snowD__pine", 81, 84 }, { "Fr_pine2", 86, 89 }, { "Fr_pine2__snow", 89, 98 }, { "Fr_pine__snowD", 98, 110 }, { "Fr_pine", 110, 113 }, { "Fr_pine2", 114, 120 }, { "Fr_pine", 120, 129 } },
  { { "Fr_pine2", 2, 23 }, { "Fr_pine", 23, 41 }, { "Fr_snow", 41, 44 }, { "Fr_snow__pine2", 44, 47 }, { "Fr_snowD__pine", 47, 53 }, { "Fr_snowD", 53, 56 }, { "Fr_post", 63, 66 }, { "Fr_lamp", 67, 70 }, { "Fr_pine2", 74, 77 }, { "Fr_pine2__snow", 77, 80 }, { "Fr_pine__snowD", 80, 86 }, { "Fr_pine", 86, 89 }, { "Fr_pine2", 89, 92 }, { "Fr_snow__pine2", 92, 95 }, { "Fr_pine2", 95, 104 }, { "Fr_pine", 104, 116 }, { "Fr_snowD__pine", 116, 119 }, { "Fr_pine", 119, 122 }, { "Fr_snow", 122, 128 }, { "Fr_snowD", 128, 137 } },
  { { "Fr_snow", 3, 21 }, { "Fr_snowD", 21, 36 }, { "Fr_pine2", 36, 45 }, { "Fr_pine", 45, 57 }, { "Fr_post", 63, 66 }, { "Fr_pine2", 72, 78 }, { "Fr_pine", 78, 87 }, { "Fr_pine2", 87, 90 }, { "Fr_pine2__snow", 90, 102 }, { "Fr_pine__snowD", 102, 117 }, { "Fr_pine__pine2", 117, 120 }, { "Fr_pine2", 120, 126 }, { "Fr_pine", 126, 138 } },
  { { "Fr_pine2", 1, 4 }, { "Fr_snow__pine2", 4, 10 }, { "Fr_pine2", 10, 25 }, { "Fr_pine", 25, 40 }, { "Fr_pine__snow", 40, 43 }, { "Fr_snow__pine2", 43, 49 }, { "Fr_snowD__pine", 49, 58 }, { "Fr_snowD", 58, 61 }, { "Fr_post", 67, 70 }, { "Fr_snow", 76, 79 }, { "Fr_snow__pine2", 79, 82 }, { "Fr_snowD__pine", 82, 88 }, { "Fr_snowD", 88, 91 }, { "Fr_snow__pine2", 91, 97 }, { "Fr_pine2", 97, 106 }, { "Fr_pine", 106, 118 }, { "Fr_snowD__pine", 118, 121 }, { "Fr_snowD__snow", 121, 124 }, { "Fr_snow", 124, 130 }, { "Fr_snowD", 130, 142 } },
  { { "Fr_pine2", 1, 25 }, { "Fr_pine__trunk", 25, 28 }, { "Fr_pine", 28, 37 }, { "Fr_pine__pine2", 37, 40 }, { "Fr_pine2", 40, 49 }, { "Fr_pine", 49, 64 }, { "Fr_glowS", 65, 77 }, { "Fr_post__glowS", 77, 80 }, { "Fr_glowS", 80, 95 }, { "Fr_pine2", 95, 104 }, { "Fr_pine__trunk", 104, 107 }, { "Fr_pine", 107, 116 }, { "Fr_pine2", 116, 128 }, { "Fr_pine__trunk", 128, 131 }, { "Fr_pine", 131, 143 }, { "Fr_pine2", 143, 152 }, { "Fr_pine", 152, 164 } },
  { { "Fr_snow", 0, 24 }, { "Fr_snow__ground", 24, 39 }, { "Fr_snow", 39, 51 }, { "Fr_trunk__snow", 51, 54 }, { "Fr_snow", 54, 60 }, { "Fr_snow__ground", 60, 69 }, { "Fr_ground", 69, 99 }, { "Fr_snow__ground", 99, 141 }, { "Fr_snow", 141, 156 }, { "Fr_trunk__snow", 156, 159 }, { "Fr_snow", 159, 171 }, { "Fr_snow__ground", 171, 174 } },
  { { "Fr_ground", 0, 174 } },
}


-- compact version for short windows (the dashboard picks it when the full art would not fit)
M.small_lines = {
  "    ▄         ▄▄█▀▀▀▀█▄▄▄  ▄▄",
  "▀▀█▀▀▀▀▀▀   ▀▀▀▀▀  ▀▀▀▀▀█▄  ▀",
  " ▀▀████              █▀▄     ",
  "  ▀▀▀▀▀ ▄▄          ▄▀▀█  ▄  ",
  " ▄▀████▀▀▀   █▀  ██▄█▀▀▀▄▀▀  ",
  " █▀▀▀▀▀▀▀▀▀  █   ▀▀▀█▀▀▀▀▀▀▀ ",
  "▄▀▀▀▀▀▀▀▀▀▀▄▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▄",
}
M.small_hl = {
  { { "Fr_snow", 4, 7 }, { "Fr_a1", 16, 25 }, { "Fr_a1__a2", 25, 37 }, { "Fr_a1", 37, 43 }, { "Fr_moon", 43, 49 }, { "Fr_a1", 51, 57 } },
  { { "Fr_a1__a2", 0, 6 }, { "Fr_a1", 6, 9 }, { "Fr_a1__pine2", 9, 12 }, { "Fr_snow__pine2", 12, 15 }, { "Fr_a1__pine", 15, 18 }, { "Fr_a1__a2", 18, 24 }, { "Fr_a1", 24, 27 }, { "Fr_a1", 30, 33 }, { "Fr_a1__a2", 33, 36 }, { "Fr_a1", 36, 39 }, { "Fr_a2", 39, 45 }, { "Fr_a3", 47, 53 }, { "Fr_a2", 53, 59 }, { "Fr_moon", 59, 65 }, { "Fr_moonD", 65, 68 }, { "Fr_a1", 70, 73 } },
  { { "Fr_a3", 1, 4 }, { "Fr_a2", 4, 7 }, { "Fr_snow", 7, 13 }, { "Fr_snowD", 13, 19 }, { "Fr_snow", 33, 36 }, { "Fr_snowD__pine", 36, 39 }, { "Fr_snowD", 39, 42 } },
  { { "Fr_pine2__snow", 2, 11 }, { "Fr_pine__snowD", 11, 17 }, { "Fr_snow", 18, 21 }, { "Fr_snowD", 21, 24 }, { "Fr_snow", 34, 37 }, { "Fr_snow__pine2", 37, 40 }, { "Fr_snowD__pine", 40, 43 }, { "Fr_snowD", 43, 46 }, { "Fr_snowD", 48, 51 } },
  { { "Fr_pine2", 1, 4 }, { "Fr_snow__pine2", 4, 7 }, { "Fr_pine2", 7, 13 }, { "Fr_pine", 13, 19 }, { "Fr_snowD__snow", 19, 22 }, { "Fr_pine2__snow", 22, 25 }, { "Fr_pine__snowD", 25, 28 }, { "Fr_post", 31, 34 }, { "Fr_post__lamp", 34, 37 }, { "Fr_snow", 39, 42 }, { "Fr_snowD", 42, 45 }, { "Fr_pine2", 45, 48 }, { "Fr_snow", 48, 51 }, { "Fr_snow__pine2", 51, 54 }, { "Fr_snowD__pine", 54, 60 }, { "Fr_snowD", 60, 63 }, { "Fr_pine2__snow", 63, 66 }, { "Fr_pine__snowD", 66, 69 } },
  { { "Fr_snow", 1, 4 }, { "Fr_snow__pine2", 4, 13 }, { "Fr_snowD__pine", 13, 19 }, { "Fr_pine2__snow", 19, 25 }, { "Fr_pine__snowD", 25, 31 }, { "Fr_post", 33, 36 }, { "Fr_pine2__snow", 39, 42 }, { "Fr_pine__snowD", 42, 45 }, { "Fr_pine2__snow", 45, 48 }, { "Fr_snow", 48, 51 }, { "Fr_snow__pine2", 51, 54 }, { "Fr_snowD__pine", 54, 60 }, { "Fr_snowD__snow", 60, 63 }, { "Fr_pine2__snow", 63, 66 }, { "Fr_pine__snowD", 66, 72 } },
  { { "Fr_snow", 0, 3 }, { "Fr_pine2__snow", 3, 15 }, { "Fr_pine__snow", 15, 18 }, { "Fr_pine2__snow", 18, 27 }, { "Fr_pine__snow", 27, 33 }, { "Fr_snow", 33, 36 }, { "Fr_glowS__ground", 36, 48 }, { "Fr_glowS__snow", 48, 51 }, { "Fr_pine2__snow", 51, 54 }, { "Fr_pine__snow", 54, 60 }, { "Fr_pine2__snow", 60, 66 }, { "Fr_pine__snow", 66, 72 }, { "Fr_pine2__snow", 72, 78 }, { "Fr_pine__snow", 78, 84 }, { "Fr_snow", 84, 87 } },
}

local PAL = {
  snow = { 112, 130, 160 },
  snowD = { 74, 90, 118 },
  ground = { 88, 104, 134 },
  pine = { 20, 34, 48 },
  pine2 = { 30, 50, 66 },
  trunk = { 44, 34, 34 },
  moon = { 196, 206, 226 },
  moonD = { 140, 154, 180 },
  a1 = { 58, 168, 122 },
  a2 = { 52, 140, 164 },
  a3 = { 104, 90, 176 },
  post = { 52, 44, 44 },
  lamp = { 255, 190, 96 },
  glow = { 178, 120, 70 },
  glowS = { 150, 116, 92 },
}
local COMBOS = { "Fr_a1__a2", "Fr_a1__pine", "Fr_a1__pine2", "Fr_a1__snowD", "Fr_a2__a3", "Fr_glowS__ground", "Fr_glowS__snow", "Fr_pine2__a3", "Fr_pine2__snow", "Fr_pine__pine2", "Fr_pine__snow", "Fr_pine__snowD", "Fr_pine__trunk", "Fr_post__glowS", "Fr_post__lamp", "Fr_snowD__pine", "Fr_snowD__snow", "Fr_snow__ground", "Fr_snow__pine2", "Fr_trunk__snow" }

local QUOTES = {
  "Keep the lantern lit.", "The snow remembers every step.", "Warm hands, steady code.",
  "Follow the aurora home.", "Rest by the fire, then press on.", "Every storm runs out of snow.",
  "Quiet woods, clear mind.", "One more log on the fire.", "The north wind favors the patient.",
  "Lanterns guide the lost.",
}
M.quote_mark = "\u{2744}"
function M.quote()
  math.randomseed(os.time())
  return QUOTES[math.random(#QUOTES)]
end

local function hex(c, k)
  local function ch(v) v = math.floor(v * k + 0.5); if v < 0 then v = 0 elseif v > 255 then v = 255 end; return v end
  return string.format("#%02x%02x%02x", ch(c[1]), ch(c[2]), ch(c[3]))
end
local gain = {}
local function color(name) return hex(PAL[name], gain[name] or 1) end

function M.apply()
  for name in pairs(PAL) do vim.api.nvim_set_hl(0, "Fr_" .. name, { fg = color(name) }) end
  for _, g in ipairs(COMBOS) do
    local a, b = g:match("^Fr_(.-)__(.+)$")
    vim.api.nvim_set_hl(0, g, { fg = color(a), bg = color(b) })
  end
  vim.api.nvim_set_hl(0, "FrStar", { fg = "#5f6b85" })
end

-- the rest of the dashboard in frost colors
function M.menu_colors()
  vim.api.nvim_set_hl(0, "AlphaMenuDescription", { fg = "#8fb0e8" })
  vim.api.nvim_set_hl(0, "AlphaMenuShortcut", { fg = "#f0b45a", bold = true })
  vim.api.nvim_set_hl(0, "AlphaQuote", { fg = "#7f9cc8", italic = true })
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
  timer:start(0, 120, vim.schedule_wrap(function()
    if not alpha_visible() then return M.stop() end
    local t = (uv.hrtime() - t0) / 1e9
    gain.a1 = 0.85 + 0.25 * math.sin(t * 0.55)
    gain.a2 = 0.85 + 0.25 * math.sin(t * 0.55 + 1.6)
    gain.a3 = 0.80 + 0.30 * math.sin(t * 0.55 + 3.1)
    local f = 0.9 + 0.08 * math.sin(t * 1.1) + 0.05 * math.sin(t * 2.3) + (math.random() - 0.5) * 0.04
    gain.lamp = f; gain.glowS = 0.92 + (f - 0.9) * 1.5
    M.apply()
  end))
end
function M.setup()
  M.apply()
  vim.schedule(M.menu_colors)
  vim.api.nvim_create_autocmd("ColorScheme", { callback = function() M.apply(); M.menu_colors() end })
  vim.api.nvim_create_autocmd("User", { pattern = "AlphaReady", callback = M.start })
  vim.api.nvim_create_autocmd("FileType", { pattern = "alpha", callback = function() vim.schedule(M.start) end })
end

return M
