-- Hackerman FX: dashboard, CRT glow, hacker diagnostics, decryption effect,
-- glitch on save, cursor trail, scanlines, code rain, intrusion detected
-- Only activates when colorscheme is "hackerman"

return {
  -- 1. Hacker Dashboard
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            "",
            "   ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗ ",
            "   ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗",
            "   ███████║███████║██║     █████╔╝ █████╗  ██████╔╝",
            "   ██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗",
            "   ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║",
            "   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝",
            "                     M  A  N                ",
            "",
            "   ┌──────────────────────────────────────────┐",
            "   │  ● status ········ connected              │",
            "   │  ● access ········ root                   │",
            "   │  ● encrypt ······· aes-256-gcm            │",
            "   │  ● system ········ ready_                 │",
            "   └──────────────────────────────────────────┘",
            "",
          }, "\n"),
        },
      },
    },
  },

  -- 2. Hacker Diagnostic Icons (only skull for errors)
  {
    "LazyVim/LazyVim",
    opts = {
      icons = {
        diagnostics = {
          Error = "☠ ",
        },
      },
    },
  },

  -- 3. All hackerman visual effects
  {
    dir = vim.fn.stdpath("config"),
    name = "hackerman-fx",
    event = "VeryLazy",
    config = function()
      local function is_hackerman()
        return vim.g.colors_name == "hackerman"
      end

      -- Filetypes/buftypes to skip for effects
      local fx_blacklist = {
        ["neo-tree"] = true,
        ["NvimTree"] = true,
        ["snacks_dashboard"] = true,
        ["dashboard"] = true,
        ["alpha"] = true,
        ["lazy"] = true,
        ["mason"] = true,
        ["TelescopePrompt"] = true,
        ["noice"] = true,
        ["notify"] = true,
        ["qf"] = true,
      }

      local function is_code_buf(buf)
        buf = buf or vim.api.nvim_get_current_buf()
        if vim.bo[buf].buftype ~= "" then return false end
        local ft = vim.bo[buf].filetype
        if fx_blacklist[ft] then return false end
        return true
      end

      -- ── Highlight Groups ─────────────────────────────────

      local function setup_highlights()
        -- CRT Glow
        vim.api.nvim_set_hl(0, "HackermanGlow1", { bg = "#111c17" })
        vim.api.nvim_set_hl(0, "HackermanGlow2", { bg = "#0e1814" })
        vim.api.nvim_set_hl(0, "HackermanGlow3", { bg = "#0c1512" })
        -- Decryption
        vim.api.nvim_set_hl(0, "HackermanDecrypt", { fg = "#48b868", bg = "#0b1210" })
        -- Cursor trail
        vim.api.nvim_set_hl(0, "HackermanTrail1", { bg = "#152a20" })
        vim.api.nvim_set_hl(0, "HackermanTrail2", { bg = "#112218" })
        vim.api.nvim_set_hl(0, "HackermanTrail3", { bg = "#0e1c15" })
        -- Glitch
        vim.api.nvim_set_hl(0, "HackermanGlitch", { fg = "#58c878", bg = "#0b1210", bold = true })
        -- Scanlines
        vim.api.nvim_set_hl(0, "HackermanScanline", { bg = "#0d1412" })
        -- Code rain
        vim.api.nvim_set_hl(0, "HackermanRain", { fg = "#1a3020" })
        -- Intrusion alert
        vim.api.nvim_set_hl(0, "HackermanIntrusion", { bg = "#1c0e0e" })
        vim.api.nvim_set_hl(0, "HackermanIntrusionTitle", { fg = "#e05050", bg = "#1c0e0e", bold = true })
        vim.api.nvim_set_hl(0, "HackermanIntrusionText", { fg = "#c04040", bg = "#1c0e0e" })
        vim.api.nvim_set_hl(0, "HackermanIntrusionBorder", { fg = "#802020", bg = "#1c0e0e" })
      end

      setup_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          if is_hackerman() then setup_highlights() end
        end,
      })


      -- ════════════════════════════════════════════════════
      -- ██  DECRYPTION EFFECT
      -- ════════════════════════════════════════════════════

      local decrypt_ns = vim.api.nvim_create_namespace("hackerman_decrypt")
      local decrypt_chars = "0123456789ABCDEFabcdef$@#%&*!<>{}[]~^=+:;"

      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function(args)
          if not is_hackerman() then return end
          local buf = args.buf
          if not is_code_buf(buf) then return end

          vim.defer_fn(function()
            if not vim.api.nvim_buf_is_valid(buf) then return end
            local win = vim.api.nvim_get_current_win()
            local height = vim.api.nvim_win_get_height(win)
            local lines = vim.api.nvim_buf_get_lines(buf, 0, height, false)
            local line_count = math.min(#lines, height)
            if line_count == 0 then return end

            for i = 0, line_count - 1 do
              local line = lines[i + 1] or ""
              local width = vim.fn.strdisplaywidth(line)
              if width > 0 then
                local rand = {}
                for _ = 1, width do
                  rand[#rand + 1] = decrypt_chars:sub(math.random(1, #decrypt_chars), math.random(1, #decrypt_chars))
                end
                pcall(vim.api.nvim_buf_set_extmark, buf, decrypt_ns, i, 0, {
                  virt_text = { { table.concat(rand), "HackermanDecrypt" } },
                  virt_text_pos = "overlay", priority = 200,
                })
              end
            end

            local revealed = 0
            local step = math.max(1, math.ceil(line_count / 8))
            local timer = vim.uv.new_timer()
            timer:start(30, 45, vim.schedule_wrap(function()
              if not vim.api.nvim_buf_is_valid(buf) then
                timer:stop(); timer:close(); return
              end
              for _ = 1, step do
                if revealed < line_count then
                  local marks = vim.api.nvim_buf_get_extmarks(buf, decrypt_ns, { revealed, 0 }, { revealed, -1 }, {})
                  for _, mark in ipairs(marks) do
                    pcall(vim.api.nvim_buf_del_extmark, buf, decrypt_ns, mark[1])
                  end
                end
                revealed = revealed + 1
              end
              if revealed >= line_count then
                timer:stop(); timer:close()
                pcall(vim.api.nvim_buf_clear_namespace, buf, decrypt_ns, 0, -1)
              end
            end))
          end, 20)
        end,
      })

      -- ════════════════════════════════════════════════════
      -- ██  GLITCH ON SAVE
      -- ════════════════════════════════════════════════════

      local glitch_ns = vim.api.nvim_create_namespace("hackerman_glitch")
      local glitch_chars = "░▒▓█▄▀╠╣╦╩═║@#$%&01"

      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function(args)
          if not is_hackerman() then return end
          local buf = args.buf
          if not is_code_buf(buf) then return end

          local top = vim.fn.line("w0") - 1
          local bot = vim.fn.line("w$") - 1
          local lines = vim.api.nvim_buf_get_lines(buf, top, bot + 1, false)

          -- Phase 1: heavy glitch
          for i = 0, #lines - 1 do
            if math.random() < 0.4 then
              local line = lines[i + 1] or ""
              local width = vim.fn.strdisplaywidth(line)
              if width > 0 then
                local rand = {}
                for _ = 1, width do
                  rand[#rand + 1] = glitch_chars:sub(math.random(1, #glitch_chars), math.random(1, #glitch_chars))
                end
                pcall(vim.api.nvim_buf_set_extmark, buf, glitch_ns, top + i, 0, {
                  virt_text = { { table.concat(rand), "HackermanGlitch" } },
                  virt_text_pos = "overlay", priority = 300,
                })
              end
            end
          end

          -- Phase 2: less glitch after 80ms
          vim.defer_fn(function()
            pcall(vim.api.nvim_buf_clear_namespace, buf, glitch_ns, 0, -1)
            for i = 0, #lines - 1 do
              if math.random() < 0.15 then
                local line = lines[i + 1] or ""
                local width = vim.fn.strdisplaywidth(line)
                if width > 0 then
                  local rand = {}
                  for _ = 1, math.min(width, math.random(3, 8)) do
                    rand[#rand + 1] = glitch_chars:sub(math.random(1, #glitch_chars), math.random(1, #glitch_chars))
                  end
                  pcall(vim.api.nvim_buf_set_extmark, buf, glitch_ns, top + i, 0, {
                    virt_text = { { table.concat(rand), "HackermanGlitch" } },
                    virt_text_pos = "overlay", priority = 300,
                  })
                end
              end
            end

            -- Phase 3: clear
            vim.defer_fn(function()
              pcall(vim.api.nvim_buf_clear_namespace, buf, glitch_ns, 0, -1)
            end, 80)
          end, 80)
        end,
      })




      -- ════════════════════════════════════════════════════
      -- ██  INTRUSION DETECTED
      -- ════════════════════════════════════════════════════

      local intrusion_shown = {}

      vim.api.nvim_create_autocmd("DiagnosticChanged", {
        callback = function(args)
          if not is_hackerman() then return end
          local buf = args.buf
          if not buf or intrusion_shown[buf] then return end
          if not is_code_buf(buf) then return end

          local errors = vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.ERROR })
          if #errors == 0 then return end

          intrusion_shown[buf] = true

          local source = errors[1].source or "unknown"
          local msg_lines = {
            "                                        ",
            "   ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄   ",
            "   █                                █   ",
            "   █   ⚠  INTRUSION DETECTED  ⚠     █   ",
            "   █                                █   ",
            "   █   unauthorized code detected   █   ",
            "   █   source: " .. source .. string.rep(" ", math.max(0, 19 - #source)) .. "  █   ",
            "   █   threat: critical              █   ",
            "   █                                █   ",
            "   ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀   ",
            "                                        ",
          }

          local float_buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, msg_lines)

          -- Highlight the buffer lines
          local hl_ns = vim.api.nvim_create_namespace("hackerman_intrusion_hl")
          for i = 0, #msg_lines - 1 do
            local hl = "HackermanIntrusion"
            if i == 3 then hl = "HackermanIntrusionTitle" end
            if i >= 5 and i <= 7 then hl = "HackermanIntrusionText" end
            if i == 1 or i == 9 then hl = "HackermanIntrusionBorder" end
            vim.api.nvim_buf_set_extmark(float_buf, hl_ns, i, 0, {
              line_hl_group = hl,
              end_row = i + 1,
            })
          end

          local width = 40
          local height = #msg_lines
          local editor_w = vim.o.columns
          local editor_h = vim.o.lines

          local float_win = vim.api.nvim_open_win(float_buf, false, {
            relative = "editor",
            width = width,
            height = height,
            col = math.floor((editor_w - width) / 2),
            row = math.floor((editor_h - height) / 2),
            style = "minimal",
            border = "none",
            zindex = 200,
          })

          vim.api.nvim_set_option_value("winhl", "Normal:HackermanIntrusion", { win = float_win })

          -- Flash effect: briefly make it brighter
          vim.defer_fn(function()
            if vim.api.nvim_win_is_valid(float_win) then
              vim.api.nvim_set_option_value("winblend", 10, { win = float_win })
            end
          end, 300)

          -- Dismiss after 2 seconds
          vim.defer_fn(function()
            if vim.api.nvim_win_is_valid(float_win) then
              vim.api.nvim_win_close(float_win, true)
            end
            if vim.api.nvim_buf_is_valid(float_buf) then
              vim.api.nvim_buf_delete(float_buf, { force = true })
            end
          end, 2000)
        end,
      })

      -- Reset intrusion tracking when buffer is wiped
      vim.api.nvim_create_autocmd("BufWipeout", {
        callback = function(args)
          intrusion_shown[args.buf] = nil
        end,
      })
    end,
  },
}
