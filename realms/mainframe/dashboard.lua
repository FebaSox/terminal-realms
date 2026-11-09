-- mainframe dashboard art for Neovim (alpha-nvim): an old CRT on a desk, code on the glass, rain behind.
-- The cursor blinks, the glass flickers and the rain shimmers while the dashboard is open.
local M = {}

M.lines = {
  "                            M                    F",
  "                            9                    %",
  "            E               5                    1",
  "           L|               \"        5  4",
  "           XL    █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀            C",
  "           41    █████▀▀▀▀▀▀▀▀▀██████████████            /",
  "           14    █████▀▀▀▀▀▀▀▀▀▀▀▀▀▀█████████            E",
  "            ~    ███████▀▀▀▀▀▀▀▀▀▀▀██████████  P  D   &% @",
  "            6    █████▀▀▀▀▀▀▀████████████████  5  D   0Z L",
  "            ▄▀   █████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀█████  M  3   /+ >",
  "            ▄▀   ████████████████████████████  P      4  0",
  "           ▄▄▄▄  █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█  0      3  5",
  "           ████▀            █████  & H C       ▄▄▄▄▄▄▄▄▄ *",
  "▄▄▄▄▄▄▄▄▄▄▄▀▀▀▀▄▄▄▄▄▄▄▄▄▄▀▀▀▀▀▀▀▀▀▀▀▄▄▄▄▄▄▄▄▄▄▄▀▀▀▀▀▀▀▀▀▄▄",
  "██████████████████████████████████████████████████████████",
}
M.hl = {
  { { "MfR1", 28, 29 }, { "MfR2", 49, 50 } },
  { { "MfR1", 28, 29 }, { "MfR2", 49, 50 } },
  { { "MfR1", 12, 13 }, { "MfR1", 28, 29 }, { "MfR2h", 49, 50 } },
  { { "MfR2", 11, 12 }, { "MfR1", 12, 13 }, { "MfR1", 28, 29 }, { "MfR3", 37, 38 }, { "MfR2", 40, 41 } },
  { { "MfR2", 11, 12 }, { "MfR1", 12, 13 }, { "Mf_hi", 17, 20 }, { "Mf_hi__case", 20, 23 }, { "Mf_hi__lip", 23, 95 }, { "Mf_hi__case", 95, 98 }, { "Mf_hi__shade", 98, 101 }, { "MfR1", 113, 114 } },
  { { "MfR2", 11, 12 }, { "MfR1", 12, 13 }, { "Mf_hi", 17, 20 }, { "Mf_case", 20, 23 }, { "Mf_lip", 23, 26 }, { "Mf_glass", 26, 32 }, { "Mf_glass__txtD", 32, 59 }, { "Mf_glass", 59, 92 }, { "Mf_lip", 92, 95 }, { "Mf_case", 95, 98 }, { "Mf_shade", 98, 101 }, { "MfR1", 113, 114 } },
  { { "MfR2h", 11, 12 }, { "MfR1", 12, 13 }, { "Mf_hi", 17, 20 }, { "Mf_case", 20, 23 }, { "Mf_lip", 23, 26 }, { "Mf_glass", 26, 32 }, { "Mf_glass__txtD", 32, 74 }, { "Mf_glass", 74, 92 }, { "Mf_lip", 92, 95 }, { "Mf_case", 95, 98 }, { "Mf_shade", 98, 101 }, { "MfR1", 113, 114 } },
  { { "MfR1", 12, 13 }, { "Mf_hi", 17, 20 }, { "Mf_case", 20, 23 }, { "Mf_lip", 23, 26 }, { "Mf_glass", 26, 38 }, { "Mf_glass__txtD", 38, 71 }, { "Mf_glass", 71, 92 }, { "Mf_lip", 92, 95 }, { "Mf_case", 95, 98 }, { "Mf_shade", 98, 101 }, { "MfR1", 103, 104 }, { "MfR3", 106, 107 }, { "MfR1", 110, 111 }, { "MfR2", 111, 112 }, { "MfR1", 113, 114 } },
  { { "MfR1", 12, 13 }, { "Mf_hi", 17, 20 }, { "Mf_case", 20, 23 }, { "Mf_lip", 23, 26 }, { "Mf_glass", 26, 32 }, { "Mf_glass__txt", 32, 53 }, { "Mf_glass", 53, 92 }, { "Mf_lip", 92, 95 }, { "Mf_case", 95, 98 }, { "Mf_shade", 98, 101 }, { "MfR1", 103, 104 }, { "MfR3", 106, 107 }, { "MfR1", 110, 111 }, { "MfR2", 111, 112 }, { "MfR1", 113, 114 } },
  { { "Mf_steam", 12, 18 }, { "Mf_hi", 21, 24 }, { "Mf_case", 24, 27 }, { "Mf_lip", 27, 30 }, { "Mf_glass", 30, 36 }, { "Mf_glass__txt", 36, 84 }, { "Mf_glass", 84, 87 }, { "Mf_glass__cur", 87, 90 }, { "Mf_glass", 90, 96 }, { "Mf_lip", 96, 99 }, { "Mf_case", 99, 102 }, { "Mf_shade", 102, 105 }, { "MfR1", 107, 108 }, { "MfR3h", 110, 111 }, { "MfR1", 114, 115 }, { "MfR2h", 115, 116 }, { "MfR1", 117, 118 } },
  { { "Mf_steam", 12, 18 }, { "Mf_hi", 21, 24 }, { "Mf_case", 24, 27 }, { "Mf_lip", 27, 30 }, { "Mf_glass", 30, 96 }, { "Mf_lip", 96, 99 }, { "Mf_case", 99, 102 }, { "Mf_shade", 102, 105 }, { "MfR1", 107, 108 }, { "MfR1", 114, 115 }, { "MfR1", 117, 118 } },
  { { "Mf_lip", 11, 23 }, { "Mf_hi", 25, 28 }, { "Mf_case__shade", 28, 31 }, { "Mf_lip__shade", 31, 100 }, { "Mf_led__shade", 100, 103 }, { "Mf_case__shade", 103, 106 }, { "Mf_shade", 106, 109 }, { "MfR1", 111, 112 }, { "MfR1h", 118, 119 }, { "MfR1", 121, 122 } },
  { { "Mf_mug", 11, 26 }, { "Mf_shade", 38, 53 }, { "MfR3", 55, 56 }, { "MfR3", 57, 58 }, { "MfR3", 59, 60 }, { "Mf_shade", 67, 70 }, { "Mf_key", 70, 73 }, { "Mf_case", 73, 76 }, { "Mf_key", 76, 79 }, { "Mf_case", 79, 82 }, { "Mf_key", 82, 85 }, { "Mf_case", 85, 88 }, { "Mf_key", 88, 91 }, { "Mf_shade", 91, 94 }, { "MfR1", 95, 96 } },
  { { "Mf_deskT", 0, 33 }, { "Mf_mug__deskT", 33, 45 }, { "Mf_deskT", 45, 75 }, { "Mf_case__deskT", 75, 108 }, { "Mf_deskT", 108, 141 }, { "Mf_shade__deskT", 141, 168 }, { "Mf_deskT", 168, 174 } },
  { { "Mf_desk", 0, 174 } },
}

-- compact version for short windows (the dashboard picks it when the full art would not fit)
M.small_lines = {
  "       █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ F+| Z",
  "       ████▀▀▀▀▀▀████████  M< +",
  "       ████▀▀▀▀▀▀▀▀▀▀████   @ &",
  "       ██████████████████   & A",
  "       █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█",
  "             █████",
  "▄▄▄▄▄▄▄▄▄▄▀▀▀▀▀▀▀▀▀▀▀▄▄▄▄▄▄▄▄▄▄▄",
  "████████████████████████████████",
}
M.small_hl = {
  { { "Mf_hi", 7, 10 }, { "Mf_hi__case", 10, 13 }, { "Mf_hi__lip", 13, 55 }, { "Mf_hi__case", 55, 58 }, { "Mf_hi__shade", 58, 61 }, { "MfR1h", 62, 63 }, { "MfR2", 63, 64 }, { "MfR1", 64, 65 }, { "MfR1", 66, 67 } },
  { { "Mf_hi", 7, 10 }, { "Mf_case", 10, 13 }, { "Mf_lip", 13, 16 }, { "Mf_glass", 16, 19 }, { "Mf_glass__txtD", 19, 37 }, { "Mf_glass", 37, 52 }, { "Mf_lip", 52, 55 }, { "Mf_case", 55, 58 }, { "Mf_shade", 58, 61 }, { "MfR2h", 63, 64 }, { "MfR1", 64, 65 }, { "MfR1", 66, 67 } },
  { { "Mf_hi", 7, 10 }, { "Mf_case", 10, 13 }, { "Mf_lip", 13, 16 }, { "Mf_glass", 16, 19 }, { "Mf_glass__txt", 19, 46 }, { "Mf_glass__cur", 46, 49 }, { "Mf_glass", 49, 52 }, { "Mf_lip", 52, 55 }, { "Mf_case", 55, 58 }, { "Mf_shade", 58, 61 }, { "MfR1", 64, 65 }, { "MfR1", 66, 67 } },
  { { "Mf_hi", 7, 10 }, { "Mf_case", 10, 13 }, { "Mf_lip", 13, 16 }, { "Mf_glass", 16, 52 }, { "Mf_lip", 52, 55 }, { "Mf_case", 55, 58 }, { "Mf_shade", 58, 61 }, { "MfR1h", 64, 65 }, { "MfR1h", 66, 67 } },
  { { "Mf_hi", 7, 10 }, { "Mf_case__shade", 10, 13 }, { "Mf_lip__shade", 13, 52 }, { "Mf_led__shade", 52, 55 }, { "Mf_case__shade", 55, 58 }, { "Mf_shade", 58, 61 } },
  { { "Mf_shade", 13, 28 } },
  { { "Mf_deskT", 0, 30 }, { "Mf_case__deskT", 30, 63 }, { "Mf_deskT", 63, 96 } },
  { { "Mf_desk", 0, 96 } },
}

local PAL = {
  glass = { 10, 10, 10 },
  desk = { 34, 34, 34 },
  deskT = { 78, 78, 78 },
  lip = { 64, 64, 64 },
  shade = { 104, 104, 104 },
  case = { 150, 150, 150 },
  hi = { 196, 196, 196 },
  txt = { 200, 200, 200 },
  txtD = { 120, 120, 120 },
  cur = { 235, 235, 235 },
  led = { 240, 240, 240 },
  key = { 176, 176, 176 },
  steam = { 70, 70, 70 },
  mug = { 196, 196, 196 },
}
local COMBOS = { "Mf_case__deskT", "Mf_case__shade", "Mf_glass__cur", "Mf_glass__txt", "Mf_glass__txtD", "Mf_hi__case", "Mf_hi__lip", "Mf_hi__shade", "Mf_led__shade", "Mf_lip__shade", "Mf_mug__deskT", "Mf_shade__deskT" }

local QUOTES = {
  "Read the source.", "Everything is a file.", "Do one thing, and do it well.", "Talk is cheap. Show me the code.",
  "There's no place like 127.0.0.1", "The quieter you become, the more you hear.", "Follow the white rabbit.",
  "It works on my machine.", "Keep it simple.", "In the beginning was the command line.", "Knock, knock.",
  "Leave the code better than you found it.",
}
M.quote_mark = "\u{00bb}"
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
local RAIN = { 90, 70, 55 }

function M.apply()
  for name in pairs(PAL) do vim.api.nvim_set_hl(0, "Mf_" .. name, { fg = color(name) }) end
  for _, g in ipairs(COMBOS) do
    local a, b = g:match("^Mf_(.-)__(.+)$")
    vim.api.nvim_set_hl(0, g, { fg = color(a), bg = color(b) })
  end
  for i, v in ipairs(RAIN) do
    local k = gain["r" .. i] or 1
    vim.api.nvim_set_hl(0, "MfR" .. i, { fg = hex({ v, v, v }, k) })
    vim.api.nvim_set_hl(0, "MfR" .. i .. "h", { fg = hex({ 230, 230, 230 }, 0.75 + 0.25 * k) })
  end
end

-- the rest of the dashboard in greys
function M.menu_colors()
  vim.api.nvim_set_hl(0, "AlphaMenuDescription", { fg = "#bdbdbd" })
  vim.api.nvim_set_hl(0, "AlphaMenuShortcut", { fg = "#f2f2f2", bold = true })
  vim.api.nvim_set_hl(0, "AlphaQuote", { fg = "#8c8c8c", italic = true })
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
    gain.cur = (t * 1.6) % 2 < 1 and 1 or 0.06                       -- blinking cursor
    local f = 0.93 + 0.05 * math.sin(t * 7.3) * math.sin(t * 2.1)     -- phosphor flicker
    gain.txt = f; gain.txtD = f; gain.led = 0.85 + 0.15 * math.sin(t * 0.8)
    gain.steam = 0.7 + 0.5 * math.sin(t * 0.9)
    for i = 1, 3 do gain["r" .. i] = 0.55 + 0.55 * (0.5 + 0.5 * math.sin(t * 0.9 + i * 2.1)) end
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
