return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night", 
      transparent = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },   
        functions = { italic = false }, 
        variables = { italic = false },
        sidebars = "normal", 
        floats = "normal",
      },
      on_colors = function(colors)
        -- Clearer slate blue base tones
        colors.bg = "#24283b"        
        colors.bg_dark = "#24283b"   
        colors.bg_float = "#24283b"  
        colors.bg_visual = "#364e7f" 
      end,
      on_highlights = function(hl, c)
        -- FORCE Neo-tree elements to use your exact clear slate blue color
        hl.NeoTreeNormal = { bg = c.bg }   
        hl.NeoTreeNormalNC = { bg = c.bg } 
        
        -- Custom clean aesthetic separator links inside TokyoNight
        hl.WinSeparator = { fg = "#2c314c", bg = "NONE" }
        hl.FloatBorder = { fg = "#2c314c", bg = "NONE" }
        hl.NeoTreeWinSeparator = { fg = "#2c314c", bg = c.bg }
      end,
    })

    -- Finally, load the theme scheme
    vim.cmd([[colorscheme tokyonight-night]])
  end
}
