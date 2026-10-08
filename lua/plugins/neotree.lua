return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", 
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        width = 30,
      },
      filesystem = {
        -- This instantly refreshes Neo-tree when files are created/deleted externally
        use_libuv_file_watcher = true, 
        
        filtered_items = {
          visible = false,        -- Hide hidden/clutter files by default
          hide_dotfiles = true,   -- Automatically hide folders like .git
          hide_gitignored = true, -- Automatically hide files in your .gitignore
          
          -- Explicitly hide these specific names
          never_show = {
            ".git",
            ".DS_Store",
          },
          -- Explicitly hide files matching these extensions
          never_show_by_pattern = {
            "*.swp", -- This completely removes those annoying .main.cpp.swp files!
            "*.o",   -- Keeps compiled C/C++ object files out of your sight too
          },
        },
        follow_current_file = {
          enabled = true,
        },
      },
    })

    -- Toggle shortcut (Space + e)
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { silent = true })
  end,
}

