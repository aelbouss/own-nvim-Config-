return {
  "sphamba/smear-cursor.nvim",
  opts = {
    stiffness = 0.8,
    trailing_stiffness = 0.5,
    distance_stop_animating = 0.1,
    -- Force animation on intra-line and small jumps
    smear_between_neighbor_lines = true,
    min_horizontal_distance = 0,
    min_vertical_distance = 0,
    legacy_computing_symbols_support = true,
  },
}
