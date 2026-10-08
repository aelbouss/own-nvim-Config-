return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      -- Add any languages you code in here so Treesitter knows how to color them!
      ensure_installed = { "lua", "c", "cpp", "python", "bash" }, 
      sync_install = false,
      highlight = { 
        enable = true, -- THIS IS CRUCIAL FOR COMPLEX IDE COLORS
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end
}
