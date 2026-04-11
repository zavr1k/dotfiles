# AGENTS
1. Repo = LazyVim-based Neovim config; keep edits Lua-centric.
2. Dependency/build: run `nvim --headless "+Lazy! sync" +qa` to install/update plugins.
3. Runtime smoke test: launch `nvim` from repo root and ensure startup has no errors.
4. No automated unit tests exist; reproduce issues manually inside Neovim.
5. Single-test equivalent: `nvim --headless "+lua dofile('lua/<path>.lua')" +qa` to exercise one module.
6. Formatting/lint: `stylua --check init.lua lua`; fix with `stylua init.lua lua`.
7. Stylua enforces 2-space indent, spaces only, 120-column wrap (see `stylua.toml`).
8. Imports: always `require("module")` via absolute paths and store handles in locals before use.
9. Plugin specs live under `lua/plugins`; each file must return a table of lazy.nvim specs.
10. Mutate plugin defaults via `opts = function(_, opts)` and prefer table helpers like `vim.list_extend`.
11. Keep configuration declarative; avoid side effects at file scope beyond returning spec tables.
12. Name locals/modules in snake_case, exported tables in UpperCamelCase only when matching LazyVim patterns.
13. Document public functions with EmmyLua annotations (`---@param`, `---@class`) when types matter.
14. Structure modules as `local M = {}` ... `return M`; never leak globals.
15. Handle failures via `vim.api.nvim_echo`/`vim.notify`, and check `vim.v.shell_error` after shell calls.
16. Options go in `lua/config/options.lua`, autocmds in `autocmds.lua`, keymaps in `keymaps.lua`; register with official APIs.
17. When adding tools, extend `mason.nvim`'s `ensure_installed` list alphabetically inside plugin specs.
18. No Cursor (.cursor) or Copilot (.github/copilot-instructions.md) rule files exist yet—add references here if they appear.
19. Keep this file authoritative for repo-wide guidance; add nested AGENTS.md files for narrower scopes when needed.