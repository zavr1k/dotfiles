-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.pack.edgedb" },
	{ import = "astrocommunity.motion.nvim-surround" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.elixir-phoenix" },
	{ import = "astrocommunity.colorscheme.everforest" },
	-- import/override with your plugins folder
}
