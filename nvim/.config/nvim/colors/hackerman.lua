-- Hackerman - A hacker-green colorscheme for comfortable all-day coding
-- Palette: green-tinted darks, varied green hues for syntax, minimal non-green accents

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "hackerman"

local c = {
  -- Background palette
  bg = "#0b1210",
  bg_dark = "#080e0c",
  bg_float = "#0f1916",
  bg_highlight = "#142019",
  bg_visual = "#1a3028",
  bg_search = "#254a38",
  bg_popup = "#0f1916",

  -- Foreground palette
  fg = "#a8b8a8",
  fg_dark = "#889888",
  fg_gutter = "#354535",
  comment = "#526e58",
  nontext = "#253228",

  -- Syntax greens (lifted for readability on dark bg)
  green = "#48b868",
  green_bright = "#58c878",
  green_dim = "#48a860",
  green_muted = "#408860",
  teal = "#58b8a0",
  cyan = "#68c0b0",
  aqua = "#58b098",

  -- Accent colors (semantic only)
  yellow = "#b8a050",
  orange = "#a07038",
  red = "#c05050",
  red_dim = "#984040",
  blue = "#5888a0",
  purple = "#7888a8",

  -- Diff / git
  diff_add = "#1a3020",
  diff_change = "#1a2830",
  diff_delete = "#301a1a",
  diff_text = "#254038",

  -- UI
  border = "#2a3f30",
  selection = "#1e3828",
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ╔══════════════════════════════════════════╗
-- ║  Editor UI                               ║
-- ╚══════════════════════════════════════════╝
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.bg_float })
hi("NormalNC", { fg = c.fg, bg = c.bg })
hi("Cursor", { fg = c.bg, bg = c.green })
hi("CursorLine", { bg = c.bg_highlight })
hi("CursorLineNr", { fg = c.green, bold = true })
hi("CursorColumn", { bg = c.bg_highlight })
hi("ColorColumn", { bg = c.bg_highlight })
hi("LineNr", { fg = c.fg_gutter })
hi("SignColumn", { fg = c.fg_gutter, bg = c.bg })
hi("FoldColumn", { fg = c.fg_gutter, bg = c.bg })
hi("Folded", { fg = c.comment, bg = c.bg_highlight })
hi("VertSplit", { fg = c.border })
hi("WinSeparator", { fg = c.border })
hi("StatusLine", { fg = c.fg, bg = c.bg_dark })
hi("StatusLineNC", { fg = c.fg_gutter, bg = c.bg_dark })
hi("TabLine", { fg = c.fg_dark, bg = c.bg_dark })
hi("TabLineFill", { bg = c.bg_dark })
hi("TabLineSel", { fg = c.green, bg = c.bg })
hi("WinBar", { fg = c.fg_dark, bg = c.bg })
hi("WinBarNC", { fg = c.fg_gutter, bg = c.bg })
hi("Pmenu", { fg = c.fg, bg = c.bg_float })
hi("PmenuSel", { fg = c.bg, bg = c.green_dim })
hi("PmenuSbar", { bg = c.bg_highlight })
hi("PmenuThumb", { bg = c.green_muted })
hi("Visual", { bg = c.bg_visual })
hi("VisualNOS", { bg = c.bg_visual })
hi("Search", { fg = c.bg, bg = c.green_dim })
hi("IncSearch", { fg = c.bg, bg = c.green })
hi("CurSearch", { fg = c.bg, bg = c.green_bright })
hi("Substitute", { fg = c.bg, bg = c.yellow })
hi("MatchParen", { fg = c.green_bright, bold = true, underline = true })
hi("NonText", { fg = c.nontext })
hi("SpecialKey", { fg = c.nontext })
hi("Whitespace", { fg = c.nontext })
hi("EndOfBuffer", { fg = c.nontext })
hi("Directory", { fg = c.teal })
hi("Title", { fg = c.green, bold = true })
hi("ErrorMsg", { fg = c.red })
hi("WarningMsg", { fg = c.yellow })
hi("ModeMsg", { fg = c.fg, bold = true })
hi("MoreMsg", { fg = c.teal })
hi("Question", { fg = c.teal })
hi("Conceal", { fg = c.fg_gutter })
hi("WildMenu", { fg = c.bg, bg = c.green })
hi("QuickFixLine", { bg = c.bg_highlight })
hi("FloatBorder", { fg = c.border, bg = c.bg_float })
hi("FloatTitle", { fg = c.green, bg = c.bg_float })
hi("WinBarNC", { fg = c.fg_gutter })

-- ╔══════════════════════════════════════════╗
-- ║  Syntax Highlighting                     ║
-- ╚══════════════════════════════════════════╝
hi("Comment", { fg = c.comment, italic = true })
hi("Constant", { fg = c.cyan })
hi("String", { fg = c.green_dim })
hi("Character", { fg = c.green_dim })
hi("Number", { fg = c.cyan })
hi("Boolean", { fg = c.cyan })
hi("Float", { fg = c.cyan })
hi("Identifier", { fg = c.fg })
hi("Function", { fg = c.teal })
hi("Statement", { fg = c.green })
hi("Conditional", { fg = c.green })
hi("Repeat", { fg = c.green })
hi("Label", { fg = c.green })
hi("Operator", { fg = c.green_muted })
hi("Keyword", { fg = c.green, bold = true })
hi("Exception", { fg = c.green })
hi("PreProc", { fg = c.aqua })
hi("Include", { fg = c.aqua })
hi("Define", { fg = c.aqua })
hi("Macro", { fg = c.aqua })
hi("PreCondit", { fg = c.aqua })
hi("Type", { fg = c.teal })
hi("StorageClass", { fg = c.green })
hi("Structure", { fg = c.teal })
hi("Typedef", { fg = c.teal })
hi("Special", { fg = c.aqua })
hi("SpecialChar", { fg = c.aqua })
hi("Tag", { fg = c.green })
hi("Delimiter", { fg = c.fg_dark })
hi("SpecialComment", { fg = c.comment, bold = true })
hi("Debug", { fg = c.yellow })
hi("Underlined", { fg = c.teal, underline = true })
hi("Ignore", { fg = c.nontext })
hi("Error", { fg = c.red })
hi("Todo", { fg = c.yellow, bold = true })
hi("Added", { fg = c.green_dim })
hi("Changed", { fg = c.blue })
hi("Removed", { fg = c.red_dim })

-- ╔══════════════════════════════════════════╗
-- ║  Treesitter                              ║
-- ╚══════════════════════════════════════════╝
hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.aqua, italic = true })
hi("@variable.parameter", { fg = c.fg_dark })
hi("@variable.member", { fg = c.fg })
hi("@constant", { fg = c.cyan })
hi("@constant.builtin", { fg = c.cyan, bold = true })
hi("@constant.macro", { fg = c.cyan })
hi("@module", { fg = c.aqua })
hi("@label", { fg = c.green })
hi("@string", { fg = c.green_dim })
hi("@string.escape", { fg = c.aqua })
hi("@string.regexp", { fg = c.aqua })
hi("@string.special", { fg = c.aqua })
hi("@character", { fg = c.green_dim })
hi("@number", { fg = c.cyan })
hi("@boolean", { fg = c.cyan })
hi("@float", { fg = c.cyan })
hi("@function", { fg = c.teal })
hi("@function.builtin", { fg = c.teal, italic = true })
hi("@function.call", { fg = c.teal })
hi("@function.macro", { fg = c.aqua })
hi("@method", { fg = c.teal })
hi("@method.call", { fg = c.teal })
hi("@constructor", { fg = c.teal, bold = true })
hi("@keyword", { fg = c.green, bold = true })
hi("@keyword.function", { fg = c.green })
hi("@keyword.operator", { fg = c.green_muted })
hi("@keyword.return", { fg = c.green })
hi("@keyword.import", { fg = c.aqua })
hi("@keyword.conditional", { fg = c.green })
hi("@keyword.repeat", { fg = c.green })
hi("@keyword.exception", { fg = c.green })
hi("@operator", { fg = c.green_muted })
hi("@punctuation.delimiter", { fg = c.fg_dark })
hi("@punctuation.bracket", { fg = c.fg_dark })
hi("@punctuation.special", { fg = c.aqua })
hi("@type", { fg = c.teal })
hi("@type.builtin", { fg = c.teal, italic = true })
hi("@type.definition", { fg = c.teal })
hi("@type.qualifier", { fg = c.green })
hi("@tag", { fg = c.green })
hi("@tag.attribute", { fg = c.teal })
hi("@tag.delimiter", { fg = c.fg_dark })
hi("@attribute", { fg = c.aqua })
hi("@property", { fg = c.fg })
hi("@comment", { fg = c.comment, italic = true })
hi("@comment.todo", { fg = c.yellow, bold = true })
hi("@comment.note", { fg = c.blue, bold = true })
hi("@comment.warning", { fg = c.yellow, bold = true })
hi("@comment.error", { fg = c.red, bold = true })
hi("@markup.heading", { fg = c.green, bold = true })
hi("@markup.strong", { bold = true })
hi("@markup.italic", { italic = true })
hi("@markup.strikethrough", { strikethrough = true })
hi("@markup.underline", { underline = true })
hi("@markup.link", { fg = c.teal, underline = true })
hi("@markup.link.url", { fg = c.blue, underline = true })
hi("@markup.raw", { fg = c.green_dim })
hi("@markup.list", { fg = c.green_muted })
hi("@diff.plus", { fg = c.green_dim })
hi("@diff.minus", { fg = c.red_dim })
hi("@diff.delta", { fg = c.blue })

-- ╔══════════════════════════════════════════╗
-- ║  LSP                                     ║
-- ╚══════════════════════════════════════════╝
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.blue })
hi("DiagnosticHint", { fg = c.teal })
hi("DiagnosticOk", { fg = c.green_dim })
hi("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = c.yellow, undercurl = true })
hi("DiagnosticUnderlineInfo", { sp = c.blue, undercurl = true })
hi("DiagnosticUnderlineHint", { sp = c.teal, undercurl = true })
hi("DiagnosticVirtualTextError", { fg = c.red_dim, bg = "#180e0e" })
hi("DiagnosticVirtualTextWarn", { fg = c.orange, bg = "#18150e" })
hi("DiagnosticVirtualTextInfo", { fg = c.blue, bg = "#0e1218" })
hi("DiagnosticVirtualTextHint", { fg = c.teal, bg = "#0e1615" })
hi("LspReferenceText", { bg = c.bg_highlight })
hi("LspReferenceRead", { bg = c.bg_highlight })
hi("LspReferenceWrite", { bg = c.bg_visual })
hi("LspSignatureActiveParameter", { fg = c.green, bold = true, underline = true })
hi("LspInfoBorder", { fg = c.border })
hi("LspInlayHint", { fg = c.fg_gutter, italic = true })

-- Semantic tokens
hi("@lsp.type.class", { link = "@type" })
hi("@lsp.type.decorator", { link = "@attribute" })
hi("@lsp.type.enum", { link = "@type" })
hi("@lsp.type.enumMember", { link = "@constant" })
hi("@lsp.type.function", { link = "@function" })
hi("@lsp.type.interface", { link = "@type" })
hi("@lsp.type.macro", { link = "@function.macro" })
hi("@lsp.type.method", { link = "@method" })
hi("@lsp.type.namespace", { link = "@module" })
hi("@lsp.type.parameter", { link = "@variable.parameter" })
hi("@lsp.type.property", { link = "@property" })
hi("@lsp.type.struct", { link = "@type" })
hi("@lsp.type.type", { link = "@type" })
hi("@lsp.type.typeParameter", { link = "@type" })
hi("@lsp.type.variable", { link = "@variable" })

-- ╔══════════════════════════════════════════╗
-- ║  Git / Diff                              ║
-- ╚══════════════════════════════════════════╝
hi("DiffAdd", { bg = c.diff_add })
hi("DiffChange", { bg = c.diff_change })
hi("DiffDelete", { bg = c.diff_delete })
hi("DiffText", { bg = c.diff_text })
hi("diffAdded", { fg = c.green_dim })
hi("diffRemoved", { fg = c.red_dim })
hi("diffChanged", { fg = c.blue })
hi("diffFile", { fg = c.teal })
hi("diffNewFile", { fg = c.green })
hi("diffOldFile", { fg = c.red_dim })

-- ╔══════════════════════════════════════════╗
-- ║  Plugin Support                          ║
-- ╚══════════════════════════════════════════╝

-- GitSigns
hi("GitSignsAdd", { fg = c.green_dim })
hi("GitSignsChange", { fg = c.blue })
hi("GitSignsDelete", { fg = c.red_dim })

-- Telescope
hi("TelescopeNormal", { fg = c.fg, bg = c.bg_float })
hi("TelescopeBorder", { fg = c.border, bg = c.bg_float })
hi("TelescopeTitle", { fg = c.green, bold = true })
hi("TelescopePromptNormal", { fg = c.fg, bg = c.bg_highlight })
hi("TelescopePromptBorder", { fg = c.border, bg = c.bg_highlight })
hi("TelescopePromptTitle", { fg = c.green, bold = true })
hi("TelescopePromptPrefix", { fg = c.green })
hi("TelescopeResultsNormal", { fg = c.fg, bg = c.bg_float })
hi("TelescopeResultsBorder", { fg = c.border, bg = c.bg_float })
hi("TelescopePreviewNormal", { fg = c.fg, bg = c.bg_dark })
hi("TelescopePreviewBorder", { fg = c.border, bg = c.bg_dark })
hi("TelescopePreviewTitle", { fg = c.teal, bold = true })
hi("TelescopeSelection", { fg = c.fg, bg = c.bg_visual })
hi("TelescopeMatching", { fg = c.green_bright, bold = true })

-- NeoTree
hi("NeoTreeNormal", { fg = c.fg_dark, bg = c.bg_dark })
hi("NeoTreeNormalNC", { fg = c.fg_dark, bg = c.bg_dark })
hi("NeoTreeDirectoryName", { fg = c.teal })
hi("NeoTreeDirectoryIcon", { fg = c.teal })
hi("NeoTreeFileName", { fg = c.fg_dark })
hi("NeoTreeGitAdded", { fg = c.green_dim })
hi("NeoTreeGitModified", { fg = c.blue })
hi("NeoTreeGitDeleted", { fg = c.red_dim })
hi("NeoTreeGitConflict", { fg = c.yellow })
hi("NeoTreeGitUntracked", { fg = c.green_muted })
hi("NeoTreeRootName", { fg = c.green, bold = true })
hi("NeoTreeIndentMarker", { fg = c.nontext })

-- Noice / Notify
hi("NoiceCmdlinePopup", { fg = c.fg, bg = c.bg_float })
hi("NoiceCmdlinePopupBorder", { fg = c.border })
hi("NoiceCmdlineIcon", { fg = c.green })
hi("NotifyINFOBorder", { fg = c.teal })
hi("NotifyINFOTitle", { fg = c.teal })
hi("NotifyINFOIcon", { fg = c.teal })
hi("NotifyWARNBorder", { fg = c.yellow })
hi("NotifyWARNTitle", { fg = c.yellow })
hi("NotifyWARNIcon", { fg = c.yellow })
hi("NotifyERRORBorder", { fg = c.red })
hi("NotifyERRORTitle", { fg = c.red })
hi("NotifyERRORIcon", { fg = c.red })

-- Indent Blankline
hi("IblIndent", { fg = c.nontext })
hi("IblScope", { fg = c.green_muted })

-- Flash.nvim
hi("FlashLabel", { fg = c.bg, bg = c.green, bold = true })
hi("FlashMatch", { fg = c.fg, bg = c.bg_visual })
hi("FlashCurrent", { fg = c.bg, bg = c.green_bright })
hi("FlashBackdrop", { fg = c.comment })

-- Which-key
hi("WhichKey", { fg = c.green })
hi("WhichKeyGroup", { fg = c.teal })
hi("WhichKeyDesc", { fg = c.fg_dark })
hi("WhichKeySeparator", { fg = c.nontext })
hi("WhichKeyValue", { fg = c.fg_gutter })

-- Dashboard / Alpha
hi("DashboardHeader", { fg = c.green })
hi("DashboardFooter", { fg = c.comment })
hi("DashboardCenter", { fg = c.teal })
hi("DashboardShortCut", { fg = c.green_dim })
hi("DashboardKey", { fg = c.green_bright })

-- Snacks Dashboard
hi("SnacksDashboardHeader", { fg = c.green })
hi("SnacksDashboardFooter", { fg = c.comment })
hi("SnacksDashboardIcon", { fg = c.teal })
hi("SnacksDashboardKey", { fg = c.green_bright, bold = true })
hi("SnacksDashboardDesc", { fg = c.fg_dark })
hi("SnacksDashboardTitle", { fg = c.green, bold = true })

-- Mini
hi("MiniStatuslineFilename", { fg = c.fg_dark, bg = c.bg_dark })
hi("MiniStatuslineDevinfo", { fg = c.fg_dark, bg = c.bg_highlight })
hi("MiniStatuslineFileinfo", { fg = c.fg_dark, bg = c.bg_highlight })
hi("MiniStatuslineModeNormal", { fg = c.bg, bg = c.green, bold = true })
hi("MiniStatuslineModeInsert", { fg = c.bg, bg = c.teal, bold = true })
hi("MiniStatuslineModeVisual", { fg = c.bg, bg = c.cyan, bold = true })
hi("MiniStatuslineModeCommand", { fg = c.bg, bg = c.yellow, bold = true })
hi("MiniStatuslineModeReplace", { fg = c.bg, bg = c.red, bold = true })

-- Lazy.nvim
hi("LazyNormal", { fg = c.fg, bg = c.bg_float })
hi("LazyButton", { fg = c.fg, bg = c.bg_highlight })
hi("LazyButtonActive", { fg = c.bg, bg = c.green })
hi("LazyH1", { fg = c.bg, bg = c.green, bold = true })
hi("LazySpecial", { fg = c.teal })
hi("LazyProgressDone", { fg = c.green })
hi("LazyProgressTodo", { fg = c.fg_gutter })

-- Mason
hi("MasonNormal", { fg = c.fg, bg = c.bg_float })
hi("MasonHeader", { fg = c.bg, bg = c.green, bold = true })
hi("MasonHighlight", { fg = c.teal })
hi("MasonHighlightBlock", { fg = c.bg, bg = c.teal })
hi("MasonHighlightBlockBold", { fg = c.bg, bg = c.green, bold = true })

-- Lualine colors (exposed as globals for lualine theme)
vim.g.hackerman_lualine = {
  normal = { a = { fg = c.bg, bg = c.green, gui = "bold" }, b = { fg = c.fg, bg = c.bg_highlight }, c = { fg = c.fg_dark, bg = c.bg_dark } },
  insert = { a = { fg = c.bg, bg = c.teal, gui = "bold" } },
  visual = { a = { fg = c.bg, bg = c.cyan, gui = "bold" } },
  replace = { a = { fg = c.bg, bg = c.red, gui = "bold" } },
  command = { a = { fg = c.bg, bg = c.yellow, gui = "bold" } },
  inactive = { a = { fg = c.fg_gutter, bg = c.bg_dark }, b = { fg = c.fg_gutter, bg = c.bg_dark }, c = { fg = c.fg_gutter, bg = c.bg_dark } },
}

-- Terminal colors
vim.g.terminal_color_0 = c.bg
vim.g.terminal_color_1 = c.red
vim.g.terminal_color_2 = c.green_dim
vim.g.terminal_color_3 = c.yellow
vim.g.terminal_color_4 = c.blue
vim.g.terminal_color_5 = c.purple
vim.g.terminal_color_6 = c.teal
vim.g.terminal_color_7 = c.fg_dark
vim.g.terminal_color_8 = c.fg_gutter
vim.g.terminal_color_9 = c.red
vim.g.terminal_color_10 = c.green
vim.g.terminal_color_11 = c.yellow
vim.g.terminal_color_12 = c.blue
vim.g.terminal_color_13 = c.purple
vim.g.terminal_color_14 = c.cyan
vim.g.terminal_color_15 = c.fg
