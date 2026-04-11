-- Cybervim - Cyberpunk colorscheme for comfortable all-day coding
-- Palette: deep dark navy, neon pink/cyan/violet accents, muted for eye comfort

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "cybervim"

local c = {
  -- Background palette (deep navy/purple tint, lifted)
  bg = "#141520",
  bg_dark = "#101118",
  bg_float = "#181a28",
  bg_highlight = "#1e2035",
  bg_visual = "#282e4a",
  bg_search = "#323a60",
  bg_popup = "#181a28",

  -- Foreground palette (cool gray, slightly toned to keep contrast)
  fg = "#b8c0d0",
  fg_dark = "#8890a0",
  fg_gutter = "#404458",
  comment = "#606898",
  nontext = "#303448",

  -- Cyberpunk neons (aligned with Snazzy p10k palette, muted)
  magenta = "#d870b8",       -- keywords (snazzy #FF6AC1)
  magenta_bright = "#e880c8", -- search highlights
  cyan = "#68b8d0",           -- functions (snazzy #9AEDFE, softened)
  cyan_bright = "#78c8e0",    -- bright matches
  purple = "#9888d0",         -- strings
  purple_dim = "#7870b8",     -- operators, delimiters
  blue = "#68b8e8",           -- types (snazzy #57C7FF)
  blue_dim = "#5898c0",       -- muted blue
  pink = "#c878b8",           -- special, macros
  neon = "#80d8f0",           -- constants, numbers

  -- Accent colors (semantic, aligned with Snazzy)
  yellow = "#d0c870",
  orange = "#c09050",
  red = "#d86060",
  red_dim = "#a85050",
  green = "#58c068",
  green_dim = "#489858",

  -- Diff / git
  diff_add = "#142820",
  diff_change = "#141828",
  diff_delete = "#281418",
  diff_text = "#1e2840",

  -- UI
  border = "#2a2e48",
  selection = "#1e2840",
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
hi("Cursor", { fg = c.bg, bg = c.magenta })
hi("CursorLine", { bg = c.bg_highlight })
hi("CursorLineNr", { fg = c.magenta, bold = true })
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
hi("TabLineSel", { fg = c.magenta, bg = c.bg })
hi("WinBar", { fg = c.fg_dark, bg = c.bg })
hi("WinBarNC", { fg = c.fg_gutter, bg = c.bg })
hi("Pmenu", { fg = c.fg, bg = c.bg_float })
hi("PmenuSel", { fg = c.bg, bg = c.cyan })
hi("PmenuSbar", { bg = c.bg_highlight })
hi("PmenuThumb", { bg = c.purple_dim })
hi("Visual", { bg = c.bg_visual })
hi("VisualNOS", { bg = c.bg_visual })
hi("Search", { fg = c.bg, bg = c.cyan })
hi("IncSearch", { fg = c.bg, bg = c.magenta })
hi("CurSearch", { fg = c.bg, bg = c.magenta_bright })
hi("Substitute", { fg = c.bg, bg = c.yellow })
hi("MatchParen", { fg = c.magenta_bright, bold = true, underline = true })
hi("NonText", { fg = c.nontext })
hi("SpecialKey", { fg = c.nontext })
hi("Whitespace", { fg = c.nontext })
hi("EndOfBuffer", { fg = c.nontext })
hi("Directory", { fg = c.cyan })
hi("Title", { fg = c.magenta, bold = true })
hi("ErrorMsg", { fg = c.red })
hi("WarningMsg", { fg = c.yellow })
hi("ModeMsg", { fg = c.fg, bold = true })
hi("MoreMsg", { fg = c.cyan })
hi("Question", { fg = c.cyan })
hi("Conceal", { fg = c.fg_gutter })
hi("WildMenu", { fg = c.bg, bg = c.magenta })
hi("QuickFixLine", { bg = c.bg_highlight })
hi("FloatBorder", { fg = c.border, bg = c.bg_float })
hi("FloatTitle", { fg = c.magenta, bg = c.bg_float })

-- ╔══════════════════════════════════════════╗
-- ║  Syntax Highlighting                     ║
-- ╚══════════════════════════════════════════╝
hi("Comment", { fg = c.comment, italic = true })
hi("Constant", { fg = c.neon })
hi("String", { fg = c.purple })
hi("Character", { fg = c.purple })
hi("Number", { fg = c.neon })
hi("Boolean", { fg = c.neon })
hi("Float", { fg = c.neon })
hi("Identifier", { fg = c.fg })
hi("Function", { fg = c.cyan })
hi("Statement", { fg = c.magenta })
hi("Conditional", { fg = c.magenta })
hi("Repeat", { fg = c.magenta })
hi("Label", { fg = c.magenta })
hi("Operator", { fg = c.purple_dim })
hi("Keyword", { fg = c.magenta, bold = true })
hi("Exception", { fg = c.magenta })
hi("PreProc", { fg = c.pink })
hi("Include", { fg = c.pink })
hi("Define", { fg = c.pink })
hi("Macro", { fg = c.pink })
hi("PreCondit", { fg = c.pink })
hi("Type", { fg = c.blue })
hi("StorageClass", { fg = c.magenta })
hi("Structure", { fg = c.blue })
hi("Typedef", { fg = c.blue })
hi("Special", { fg = c.pink })
hi("SpecialChar", { fg = c.pink })
hi("Tag", { fg = c.magenta })
hi("Delimiter", { fg = c.fg_dark })
hi("SpecialComment", { fg = c.comment, bold = true })
hi("Debug", { fg = c.yellow })
hi("Underlined", { fg = c.cyan, underline = true })
hi("Ignore", { fg = c.nontext })
hi("Error", { fg = c.red })
hi("Todo", { fg = c.yellow, bold = true })
hi("Added", { fg = c.green })
hi("Changed", { fg = c.blue })
hi("Removed", { fg = c.red_dim })

-- ╔══════════════════════════════════════════╗
-- ║  Treesitter                              ║
-- ╚══════════════════════════════════════════╝
hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.pink, italic = true })
hi("@variable.parameter", { fg = c.fg_dark })
hi("@variable.member", { fg = c.fg })
hi("@constant", { fg = c.neon })
hi("@constant.builtin", { fg = c.neon, bold = true })
hi("@constant.macro", { fg = c.neon })
hi("@module", { fg = c.pink })
hi("@label", { fg = c.magenta })
hi("@string", { fg = c.purple })
hi("@string.escape", { fg = c.pink })
hi("@string.regexp", { fg = c.pink })
hi("@string.special", { fg = c.pink })
hi("@character", { fg = c.purple })
hi("@number", { fg = c.neon })
hi("@boolean", { fg = c.neon })
hi("@float", { fg = c.neon })
hi("@function", { fg = c.cyan })
hi("@function.builtin", { fg = c.cyan, italic = true })
hi("@function.call", { fg = c.cyan })
hi("@function.macro", { fg = c.pink })
hi("@method", { fg = c.cyan })
hi("@method.call", { fg = c.cyan })
hi("@constructor", { fg = c.blue, bold = true })
hi("@keyword", { fg = c.magenta, bold = true })
hi("@keyword.function", { fg = c.magenta })
hi("@keyword.operator", { fg = c.purple_dim })
hi("@keyword.return", { fg = c.magenta })
hi("@keyword.import", { fg = c.pink })
hi("@keyword.conditional", { fg = c.magenta })
hi("@keyword.repeat", { fg = c.magenta })
hi("@keyword.exception", { fg = c.magenta })
hi("@operator", { fg = c.purple_dim })
hi("@punctuation.delimiter", { fg = c.fg_dark })
hi("@punctuation.bracket", { fg = c.fg_dark })
hi("@punctuation.special", { fg = c.pink })
hi("@type", { fg = c.blue })
hi("@type.builtin", { fg = c.blue, italic = true })
hi("@type.definition", { fg = c.blue })
hi("@type.qualifier", { fg = c.magenta })
hi("@tag", { fg = c.magenta })
hi("@tag.attribute", { fg = c.cyan })
hi("@tag.delimiter", { fg = c.fg_dark })
hi("@attribute", { fg = c.pink })
hi("@property", { fg = c.fg })
hi("@comment", { fg = c.comment, italic = true })
hi("@comment.todo", { fg = c.yellow, bold = true })
hi("@comment.note", { fg = c.cyan, bold = true })
hi("@comment.warning", { fg = c.yellow, bold = true })
hi("@comment.error", { fg = c.red, bold = true })
hi("@markup.heading", { fg = c.magenta, bold = true })
hi("@markup.strong", { bold = true })
hi("@markup.italic", { italic = true })
hi("@markup.strikethrough", { strikethrough = true })
hi("@markup.underline", { underline = true })
hi("@markup.link", { fg = c.cyan, underline = true })
hi("@markup.link.url", { fg = c.blue_dim, underline = true })
hi("@markup.raw", { fg = c.purple })
hi("@markup.list", { fg = c.purple_dim })
hi("@diff.plus", { fg = c.green })
hi("@diff.minus", { fg = c.red_dim })
hi("@diff.delta", { fg = c.blue })

-- ╔══════════════════════════════════════════╗
-- ║  LSP                                     ║
-- ╚══════════════════════════════════════════╝
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.blue_dim })
hi("DiagnosticHint", { fg = c.cyan })
hi("DiagnosticOk", { fg = c.green })
hi("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = c.yellow, undercurl = true })
hi("DiagnosticUnderlineInfo", { sp = c.blue_dim, undercurl = true })
hi("DiagnosticUnderlineHint", { sp = c.cyan, undercurl = true })
hi("DiagnosticVirtualTextError", { fg = c.red_dim, bg = "#201518" })
hi("DiagnosticVirtualTextWarn", { fg = c.orange, bg = "#201c15" })
hi("DiagnosticVirtualTextInfo", { fg = c.blue_dim, bg = "#151820" })
hi("DiagnosticVirtualTextHint", { fg = c.cyan, bg = "#151c20" })
hi("LspReferenceText", { bg = c.bg_highlight })
hi("LspReferenceRead", { bg = c.bg_highlight })
hi("LspReferenceWrite", { bg = c.bg_visual })
hi("LspSignatureActiveParameter", { fg = c.magenta, bold = true, underline = true })
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
hi("diffAdded", { fg = c.green })
hi("diffRemoved", { fg = c.red_dim })
hi("diffChanged", { fg = c.blue })
hi("diffFile", { fg = c.cyan })
hi("diffNewFile", { fg = c.green })
hi("diffOldFile", { fg = c.red_dim })

-- ╔══════════════════════════════════════════╗
-- ║  Plugin Support                          ║
-- ╚══════════════════════════════════════════╝

-- GitSigns
hi("GitSignsAdd", { fg = c.green })
hi("GitSignsChange", { fg = c.blue })
hi("GitSignsDelete", { fg = c.red_dim })

-- Telescope
hi("TelescopeNormal", { fg = c.fg, bg = c.bg_float })
hi("TelescopeBorder", { fg = c.border, bg = c.bg_float })
hi("TelescopeTitle", { fg = c.magenta, bold = true })
hi("TelescopePromptNormal", { fg = c.fg, bg = c.bg_highlight })
hi("TelescopePromptBorder", { fg = c.border, bg = c.bg_highlight })
hi("TelescopePromptTitle", { fg = c.magenta, bold = true })
hi("TelescopePromptPrefix", { fg = c.magenta })
hi("TelescopeResultsNormal", { fg = c.fg, bg = c.bg_float })
hi("TelescopeResultsBorder", { fg = c.border, bg = c.bg_float })
hi("TelescopePreviewNormal", { fg = c.fg, bg = c.bg_dark })
hi("TelescopePreviewBorder", { fg = c.border, bg = c.bg_dark })
hi("TelescopePreviewTitle", { fg = c.cyan, bold = true })
hi("TelescopeSelection", { fg = c.fg, bg = c.bg_visual })
hi("TelescopeMatching", { fg = c.magenta_bright, bold = true })

-- NeoTree
hi("NeoTreeNormal", { fg = c.fg_dark, bg = c.bg_dark })
hi("NeoTreeNormalNC", { fg = c.fg_dark, bg = c.bg_dark })
hi("NeoTreeDirectoryName", { fg = c.cyan })
hi("NeoTreeDirectoryIcon", { fg = c.cyan })
hi("NeoTreeFileName", { fg = c.fg_dark })
hi("NeoTreeGitAdded", { fg = c.green })
hi("NeoTreeGitModified", { fg = c.blue })
hi("NeoTreeGitDeleted", { fg = c.red_dim })
hi("NeoTreeGitConflict", { fg = c.yellow })
hi("NeoTreeGitUntracked", { fg = c.purple_dim })
hi("NeoTreeRootName", { fg = c.magenta, bold = true })
hi("NeoTreeIndentMarker", { fg = c.nontext })

-- Noice / Notify
hi("NoiceCmdlinePopup", { fg = c.fg, bg = c.bg_float })
hi("NoiceCmdlinePopupBorder", { fg = c.border })
hi("NoiceCmdlineIcon", { fg = c.magenta })
hi("NotifyINFOBorder", { fg = c.cyan })
hi("NotifyINFOTitle", { fg = c.cyan })
hi("NotifyINFOIcon", { fg = c.cyan })
hi("NotifyWARNBorder", { fg = c.yellow })
hi("NotifyWARNTitle", { fg = c.yellow })
hi("NotifyWARNIcon", { fg = c.yellow })
hi("NotifyERRORBorder", { fg = c.red })
hi("NotifyERRORTitle", { fg = c.red })
hi("NotifyERRORIcon", { fg = c.red })

-- Indent Blankline
hi("IblIndent", { fg = c.nontext })
hi("IblScope", { fg = c.purple_dim })

-- Flash.nvim
hi("FlashLabel", { fg = c.bg, bg = c.magenta, bold = true })
hi("FlashMatch", { fg = c.fg, bg = c.bg_visual })
hi("FlashCurrent", { fg = c.bg, bg = c.cyan_bright })
hi("FlashBackdrop", { fg = c.comment })

-- Which-key
hi("WhichKey", { fg = c.magenta })
hi("WhichKeyGroup", { fg = c.cyan })
hi("WhichKeyDesc", { fg = c.fg_dark })
hi("WhichKeySeparator", { fg = c.nontext })
hi("WhichKeyValue", { fg = c.fg_gutter })

-- Dashboard / Alpha
hi("DashboardHeader", { fg = c.magenta })
hi("DashboardFooter", { fg = c.comment })
hi("DashboardCenter", { fg = c.cyan })
hi("DashboardShortCut", { fg = c.purple })
hi("DashboardKey", { fg = c.magenta_bright })

-- Mini
hi("MiniStatuslineFilename", { fg = c.fg_dark, bg = c.bg_dark })
hi("MiniStatuslineDevinfo", { fg = c.fg_dark, bg = c.bg_highlight })
hi("MiniStatuslineFileinfo", { fg = c.fg_dark, bg = c.bg_highlight })
hi("MiniStatuslineModeNormal", { fg = c.bg, bg = c.magenta, bold = true })
hi("MiniStatuslineModeInsert", { fg = c.bg, bg = c.cyan, bold = true })
hi("MiniStatuslineModeVisual", { fg = c.bg, bg = c.purple, bold = true })
hi("MiniStatuslineModeCommand", { fg = c.bg, bg = c.yellow, bold = true })
hi("MiniStatuslineModeReplace", { fg = c.bg, bg = c.red, bold = true })

-- Lazy.nvim
hi("LazyNormal", { fg = c.fg, bg = c.bg_float })
hi("LazyButton", { fg = c.fg, bg = c.bg_highlight })
hi("LazyButtonActive", { fg = c.bg, bg = c.magenta })
hi("LazyH1", { fg = c.bg, bg = c.magenta, bold = true })
hi("LazySpecial", { fg = c.cyan })
hi("LazyProgressDone", { fg = c.magenta })
hi("LazyProgressTodo", { fg = c.fg_gutter })

-- Mason
hi("MasonNormal", { fg = c.fg, bg = c.bg_float })
hi("MasonHeader", { fg = c.bg, bg = c.magenta, bold = true })
hi("MasonHighlight", { fg = c.cyan })
hi("MasonHighlightBlock", { fg = c.bg, bg = c.cyan })
hi("MasonHighlightBlockBold", { fg = c.bg, bg = c.magenta, bold = true })

-- Lualine colors (exposed as globals for lualine theme)
vim.g.cybervim_lualine = {
  normal = { a = { fg = c.bg, bg = c.magenta, gui = "bold" }, b = { fg = c.fg, bg = c.bg_highlight }, c = { fg = c.fg_dark, bg = c.bg_dark } },
  insert = { a = { fg = c.bg, bg = c.cyan, gui = "bold" } },
  visual = { a = { fg = c.bg, bg = c.purple, gui = "bold" } },
  replace = { a = { fg = c.bg, bg = c.red, gui = "bold" } },
  command = { a = { fg = c.bg, bg = c.yellow, gui = "bold" } },
  inactive = { a = { fg = c.fg_gutter, bg = c.bg_dark }, b = { fg = c.fg_gutter, bg = c.bg_dark }, c = { fg = c.fg_gutter, bg = c.bg_dark } },
}

-- Terminal colors
vim.g.terminal_color_0 = c.bg
vim.g.terminal_color_1 = c.red
vim.g.terminal_color_2 = c.green
vim.g.terminal_color_3 = c.yellow
vim.g.terminal_color_4 = c.blue
vim.g.terminal_color_5 = c.magenta
vim.g.terminal_color_6 = c.cyan
vim.g.terminal_color_7 = c.fg_dark
vim.g.terminal_color_8 = c.fg_gutter
vim.g.terminal_color_9 = c.red
vim.g.terminal_color_10 = c.green
vim.g.terminal_color_11 = c.yellow
vim.g.terminal_color_12 = c.blue
vim.g.terminal_color_13 = c.magenta_bright
vim.g.terminal_color_14 = c.cyan_bright
vim.g.terminal_color_15 = c.fg
