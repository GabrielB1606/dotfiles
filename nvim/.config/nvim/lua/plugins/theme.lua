-- https://github.com/tahayvr/vhs80.nvim/tree/main
return {
  {
    "tahayvr/vhs80.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local vhs80 = require("vhs80.colors")
      ---------------------------------------------------------------------------
      -- CORE BACKGROUND SHADES (dark → light)
      -- bg0: Extreme darkest background. Use sparingly (e.g. backdrop, contrast)
      vhs80.palette.bg0 = "#0D0D0D"
      -- bg1: Primary editor background (Normal). Change this first when theming.
      vhs80.palette.bg1 = "#121212"
      -- bg2: Secondary surface (CursorLine, popup menus, subtle panels, selection bg)
      vhs80.palette.bg2 = "#333333"
      -- bg3: Elevated / emphasized surface (statusline, tabline selected, titles)
      vhs80.palette.bg3 = "#212121"

      ---------------------------------------------------------------------------
      -- CORE FOREGROUNDS (bright → dim)
      -- fg0: Maximum contrast foreground (headings, strong emphasis)
      vhs80.palette.fg0 = "#FFFFFF"
      -- fg1: Primary text (Normal fg). Your main readable color.
      vhs80.palette.fg1 = "#EAEAEA"
      -- fg2: Secondary text (less important content, doc strings, mild dim)
      vhs80.palette.fg2 = "#BEBEBE"
      -- fg3: Tertiary / subtle text (line numbers, inactive, meta info)
      vhs80.palette.fg3 = "#8A8A8D"

      ---------------------------------------------------------------------------
      -- SELECTION & MISC
      -- selbg: Visual selection background, also used for inverse accents
      vhs80.palette.selbg = "#262626"
      -- selfg: Foreground inside selected regions (ensure contrast vs selbg)
      vhs80.palette.selfg = "#EAEAEA"
      -- comment: Comment text + doc annotations (generally muted)
      vhs80.palette.comment = "#8A8A8D"

      ---------------------------------------------------------------------------
      -- ACCENT / SEMANTIC COLOR SLOTS
      -- color1: Error / critical / strong statement (used for errors, statements, git removed)
      vhs80.palette.color1 = "#C6B441"
      -- color2: Primary accent / info highlight (mode indicators, roots, success/add)
      vhs80.palette.color2 = "#5CA7F1"
      -- color3: Attention / todo / highlight matches (TODO tags, search matches)
      vhs80.palette.color3 = "#E5D69A"
      -- color4: Modified / constant / neutral warm accent (constants, modified files)
      vhs80.palette.color4 = "#81FAF1"
      -- color5: Type / secondary accent / soft alert (types, replace mode, interface)
      vhs80.palette.color5 = "#B0E567"
      -- color6: Keywords / strong structural tokens / alternate error (keywords, visual mode bg, directives)
      vhs80.palette.color6 = "#F87171"

      ---------------------------------------------------------------------------
      -- UI DECORATIVE & LOW EMPHASIS ELEMENTS
      -- uic1: Borders, separators, guides, non-content structural UI
      vhs80.palette.uic1 = "#5C6370"
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vhs80",
    },
  },
}
