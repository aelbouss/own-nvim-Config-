-- ==========================================================================
-- ULTRA SLIM LAZYVIM REAL-TIME STATUSLINE
-- ==========================================================================
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local bar_bg = "#2c314c"       -- Lighter, clear slate blue background
    local text_active = "#a9b1d6"  -- Active file text color
    local text_dim = "#787c99"     -- Inactive metrics tracking text

    -- Core structural lines matching your theme palette
    vim.api.nvim_set_hl(0, "StatusLine",   { bg = bar_bg, fg = text_dim })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = bar_bg, fg = "#565f89" })
    vim.api.nvim_set_hl(0, "MsgArea",      { bg = bar_bg })

    -- LazyVim component color mappings
    vim.api.nvim_set_hl(0, "StatusGit",     { bg = bar_bg, fg = "#565f89" })
    vim.api.nvim_set_hl(0, "StatusDiffAdd", { bg = bar_bg, fg = "#449dab" })
    vim.api.nvim_set_hl(0, "StatusDiffMod", { bg = bar_bg, fg = "#61afef" })
    vim.api.nvim_set_hl(0, "StatusDiffDel", { bg = bar_bg, fg = "#914c54" })
    vim.api.nvim_set_hl(0, "StatusFile",    { bg = bar_bg, fg = text_active, bold = true })
    vim.api.nvim_set_hl(0, "StatusRuler",   { bg = bar_bg, fg = text_dim })

    -- LSP Diagnostic color mappings
    vim.api.nvim_set_hl(0, "StatusDiagErr", { bg = bar_bg, fg = "#f7768e", bold = true })
    vim.api.nvim_set_hl(0, "StatusDiagWrn", { bg = bar_bg, fg = "#e0af68", bold = true })
    vim.api.nvim_set_hl(0, "StatusDiagHnt", { bg = bar_bg, fg = "#1abc9c", bold = true })
    vim.api.nvim_set_hl(0, "StatusDiagInf", { bg = bar_bg, fg = "#0db9d7", bold = true })

    -- Elegant text modes matching LazyVim's low-profile style
    vim.api.nvim_set_hl(0, "ModeNormal",  { bg = bar_bg, fg = "#7aa2f7", bold = true })
    vim.api.nvim_set_hl(0, "ModeInsert",  { bg = bar_bg, fg = "#7eccdb", bold = true })
    vim.api.nvim_set_hl(0, "ModeVisual",  { bg = bar_bg, fg = "#bb9af7", bold = true })
    vim.api.nvim_set_hl(0, "ModeReplace", { bg = bar_bg, fg = "#f7768e", bold = true })
    vim.api.nvim_set_hl(0, "ModeCmd",     { bg = bar_bg, fg = "#ff9e64", bold = true })
  end,
})

-- Mode tracking with direct LazyVim icons and shorter text spans
local modes = {
  ["n"]  = { "NORMAL", "ModeNormal" },
  ["v"]  = { "VISUAL", "ModeVisual" },
  ["V"]  = { "V-LINE", "ModeVisual" },
  ["␖"] = { "V-BLOCK", "ModeVisual" },
  ["i"]  = { "INSERT", "ModeInsert" },
  ["R"]  = { "REPLACE", "ModeReplace" },
  ["c"]  = { "COMMAND", "ModeCmd" },
}

local has_icons, devicons = pcall(require, "nvim-web-devicons")

-- 1. File Path Segment (LazyVim prints relative workspace paths)
local function get_file_info()
  local path = vim.fn.expand("%:f")
  if path == "" then return "[No Name]" end
  local fname = vim.fn.expand("%:t")
  local ext = vim.fn.expand("%:e")
  local icon = ""
  if has_icons then
    local icon_str, _ = devicons.get_icon(fname, ext, { default = true })
    if icon_str then icon = icon_str .. " " end
  end
  local modified = vim.bo.modified and " 󰷥" or ""
  return icon .. path .. modified
end

-- 2. Git Module: Branch name + Real-time tracking signs
local function get_git_status()
  local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
  if branch == "" then return "" end

  local res = " %#StatusGit# " .. branch .. " "
  
  local dict = vim.b.gitsigns_status_dict
  if dict then
    if dict.added and dict.added > 0 then res = res .. "%#StatusDiffAdd#+" .. dict.added .. " " end
    if dict.changed and dict.changed > 0 then res = res .. "%#StatusDiffMod#~" .. dict.changed .. " " end
    if dict.removed and dict.removed > 0 then res = res .. "%#StatusDiffDel#-" .. dict.removed .. " " end
  end
  return res
end

-- 3. Dynamic LSP Diagnostics Block (Errors, Warnings, Hints, Info tokens)
local function get_diagnostics()
  if #vim.lsp.get_clients({ bufnr = 0 }) == 0 then return "" end
  
  local err = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local wrn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local hnt = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local inf = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

  local res = ""
  if err > 0 then res = res .. " %#StatusDiagErr# " .. err end
  if wrn > 0 then res = res .. " %#StatusDiagWrn# " .. wrn end
  if hnt > 0 then res = res .. " %#StatusDiagHnt# " .. hnt end
  if inf > 0 then res = res .. " %#StatusDiagInf# " .. inf end
  return res
end

-- ==========================================================================
-- ENGINE GENERATOR ASSEMBLY
-- ==========================================================================
function _G.custom_statusline()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_data = modes[current_mode] or { "NORMAL", "ModeNormal" }
  
  local parts = {
    -- No leading spaces, keeps the vertical height down tight
    "%#" .. mode_data[2] .. "#" .. mode_data[1] .. " ",
    get_git_status(),
    "%#StatusFile# " .. get_file_info() .. " ",
    get_diagnostics(),
    "%=",
    "%#StatusRuler#%Y │ %p%% │  %l:%c ",
  }
  return table.concat(parts)
end

-- Force ultra-low horizontal structure parameters
vim.opt.statusline = "%!v:lua.custom_statusline()"
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
