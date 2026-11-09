local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(path) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", path })
end
vim.opt.rtp:prepend(path)
require("lazy").setup({ { import = "realmkit.plugins" } }, {
  change_detection = { notify = false },
  install = { colorscheme = { "tokyonight" } },
})
