return {
  {
    "folke/snacks.nvim",
    opts = {
      zen = {
        toggles = {
          dim = false, -- не затемнять текст вокруг курсора
        },
      },
      styles = {
        zen = {
          -- По умолчанию заслонка прозрачная (transparent = true, blend = 40),
          -- поэтому сквозь неё просвечивает буфер. С transparent = false snacks
          -- считает цвет заранее и ставит winblend = 0 — окно непрозрачное.
          -- Цвет = blend(Normal.bg, #000000, blend/100): 0 — чистый чёрный,
          -- 99 — ровно Normal.bg (100 нельзя, при нём заслонки не будет вовсе,
          -- см. win.lua:1058). 50 — заметно темнее фона, но не чёрный.
          backdrop = { transparent = false, blend = 50 },
        },
      },
    },
  },
}
