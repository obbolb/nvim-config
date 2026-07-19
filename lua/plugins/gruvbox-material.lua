return {
  "sainnhe/gruvbox-material",
  lazy = false, -- We want the colorscheme to load immediately
  priority = 1000, -- Ensure it loads before other plugins to prevent UI flashing
  config = function()
    -- Optional: Configure gruvbox-material settings here
    -- Background options: 'hard', 'medium' (default), or 'soft'
    vim.g.gruvbox_material_background = "medium"
    -- Foreground options: 'material' (default), 'mix', or 'original'
    vim.g.gruvbox_material_foreground = "material"
    -- Enable italics (1 for true, 0 for false
    vim.g.gruvbox_material_enable_italic = 1
    -- Transparent background (1 for true, 0 for false)
    vim.g.gruvbox_material_transparent_background = 0
  end,
}
