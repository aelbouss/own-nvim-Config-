-- 1. Load the native settings and shortcuts immediately
require("core.options")
require("core.keymaps")
require("core.statusline")
-- 2. Bootstrap Lazy.nvim (the plugin manager tool)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Tell Lazy to automatically scan your plugins directory!
require("lazy").setup("plugins")
