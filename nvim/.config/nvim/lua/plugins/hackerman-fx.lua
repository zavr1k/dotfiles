-- Hackerman FX: boot animation, dashboard, diagnostics icons,
-- decryption effect, glitch on save, intrusion detected, exit effect
-- Only activates when colorscheme is "hackerman"

return {
  -- 1. Hacker Dashboard + Boot Animation
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            "",
            "   ███████╗ ██████╗ █████╗ ███╗  ██╗",
            "   ██╔════╝██╔════╝██╔══██╗████╗ ██║",
            "   ███████╗██║     ███████║██╔██╗██║",
            "   ╚════██║██║     ██╔══██║██║╚████║",
            "   ███████║╚██████╗██║  ██║██║ ╚███║",
            "   ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚══╝",
            "         F  A  C  T  O  R  Y        ",
            "",
          }, "\n"),
        },
      },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
    end,
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
        if vim.bo[buf].buftype ~= "" then
          return false
        end
        if fx_blacklist[vim.bo[buf].filetype] then
          return false
        end
        return true
      end

      -- ── Highlight Groups ─────────────────────────────────

      local function setup_highlights()
        -- Decryption gradient (bright -> mid -> dim)
        vim.api.nvim_set_hl(0, "HackermanDecrypt3", { fg = "#58c878", bg = "#0b1210", bold = true })
        vim.api.nvim_set_hl(0, "HackermanDecrypt2", { fg = "#38a858", bg = "#0b1210" })
        vim.api.nvim_set_hl(0, "HackermanDecrypt1", { fg = "#28884a", bg = "#0b1210" })
        -- Glitch on save
        vim.api.nvim_set_hl(0, "HackermanGlitch", { fg = "#58c878", bg = "#0b1210", bold = true })
        -- Intrusion alert
        vim.api.nvim_set_hl(0, "HackermanIntrusion", { bg = "#1c0e0e" })
        vim.api.nvim_set_hl(0, "HackermanIntrusionTitle", { fg = "#e05050", bg = "#1c0e0e", bold = true })
        vim.api.nvim_set_hl(0, "HackermanIntrusionText", { fg = "#c04040", bg = "#1c0e0e" })
        vim.api.nvim_set_hl(0, "HackermanIntrusionBorder", { fg = "#802020", bg = "#1c0e0e" })
      end

      setup_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          if is_hackerman() then
            setup_highlights()
          end
        end,
      })

      -- ════════════════════════════════════════════════════
      -- ██  DECRYPTION EFFECT (gradient, random reveal)
      -- ════════════════════════════════════════════════════

      local decrypt_ns = vim.api.nvim_create_namespace("hackerman_decrypt")

      local function mix_text(real, ratio)
        local result = {}
        for i = 1, #real do
          if math.random() < ratio then
            result[#result + 1] = real:sub(i, i)
          else
            result[#result + 1] = math.random(0, 1) == 1 and "1" or "0"
          end
        end
        return table.concat(result)
      end

      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function(args)
          if not is_hackerman() then
            return
          end
          local buf = args.buf
          if not is_code_buf(buf) then
            return
          end

          vim.defer_fn(function()
            if not vim.api.nvim_buf_is_valid(buf) then
              return
            end
            local win = vim.api.nvim_get_current_win()
            local height = vim.api.nvim_win_get_height(win)
            local lines = vim.api.nvim_buf_get_lines(buf, 0, height, false)
            local line_count = math.min(#lines, height)
            if line_count == 0 then
              return
            end

            local widths = {}
            for i = 0, line_count - 1 do
              widths[i] = vim.fn.strdisplaywidth(lines[i + 1] or "")
            end

            -- Random reveal order
            local order = {}
            for i = 0, line_count - 1 do
              order[#order + 1] = i
            end
            for i = #order, 2, -1 do
              local j = math.random(1, i)
              order[i], order[j] = order[j], order[i]
            end

            -- Initial overlay: full binary noise
            for i = 0, line_count - 1 do
              if widths[i] > 0 then
                pcall(vim.api.nvim_buf_set_extmark, buf, decrypt_ns, i, 0, {
                  virt_text = { { mix_text(lines[i + 1] or "", 0), "HackermanDecrypt3" } },
                  virt_text_pos = "overlay",
                  priority = 200,
                })
              end
            end

            local state = {}
            for i = 0, line_count - 1 do
              state[i] = 0
            end

            local reveal_idx = 1
            local lines_per_tick = math.max(3, math.ceil(line_count / 4))
            local timer = vim.uv.new_timer()

            timer:start(
              20,
              25,
              vim.schedule_wrap(function()
                if not vim.api.nvim_buf_is_valid(buf) then
                  timer:stop()
                  timer:close()
                  return
                end

                for _ = 1, lines_per_tick do
                  if reveal_idx > #order then
                    break
                  end
                  local line_i = order[reveal_idx]
                  local real = lines[line_i + 1] or ""
                  local w = widths[line_i]
                  reveal_idx = reveal_idx + 1

                  if w > 0 then
                    state[line_i] = state[line_i] + 1
                    local s = state[line_i]

                    local marks = vim.api.nvim_buf_get_extmarks(buf, decrypt_ns, { line_i, 0 }, { line_i, -1 }, {})
                    for _, m in ipairs(marks) do
                      pcall(vim.api.nvim_buf_del_extmark, buf, decrypt_ns, m[1])
                    end

                    if s == 1 then
                      pcall(vim.api.nvim_buf_set_extmark, buf, decrypt_ns, line_i, 0, {
                        virt_text = { { mix_text(real, 0.3), "HackermanDecrypt2" } },
                        virt_text_pos = "overlay",
                        priority = 200,
                      })
                      order[#order + 1] = line_i
                    elseif s == 2 then
                      pcall(vim.api.nvim_buf_set_extmark, buf, decrypt_ns, line_i, 0, {
                        virt_text = { { mix_text(real, 0.7), "HackermanDecrypt1" } },
                        virt_text_pos = "overlay",
                        priority = 200,
                      })
                      order[#order + 1] = line_i
                    end
                  end
                end

                local all_done = true
                for i = 0, line_count - 1 do
                  if state[i] < 3 and widths[i] > 0 then
                    all_done = false
                    break
                  end
                end
                if all_done or reveal_idx > #order then
                  timer:stop()
                  timer:close()
                  pcall(vim.api.nvim_buf_clear_namespace, buf, decrypt_ns, 0, -1)
                end
              end)
            )
          end, 20)
        end,
      })

      -- ════════════════════════════════════════════════════
      -- ██  GLITCH ON SAVE (binary wave)
      -- ════════════════════════════════════════════════════

      local glitch_ns = vim.api.nvim_create_namespace("hackerman_glitch")

      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function(args)
          if not is_hackerman() then
            return
          end
          local buf = args.buf
          if not is_code_buf(buf) then
            return
          end

          local top = vim.fn.line("w0") - 1
          local bot = vim.fn.line("w$") - 1
          local lines_text = vim.api.nvim_buf_get_lines(buf, top, bot + 1, false)
          local visible = #lines_text
          local wave_pos = 0
          local wave_width = 8
          local wave_speed = 2
          local timer = vim.uv.new_timer()

          timer:start(
            0,
            22,
            vim.schedule_wrap(function()
              if not vim.api.nvim_buf_is_valid(buf) or wave_pos > visible + wave_width then
                timer:stop()
                timer:close()
                pcall(vim.api.nvim_buf_clear_namespace, buf, glitch_ns, 0, -1)
                return
              end

              pcall(vim.api.nvim_buf_clear_namespace, buf, glitch_ns, 0, -1)

              for offset = 0, wave_width - 1 do
                local i = wave_pos - offset
                if i >= 0 and i < visible then
                  local line = lines_text[i + 1] or ""
                  local len = #line
                  if len > 2 then
                    local rand = {}
                    for _ = 1, len do
                      rand[#rand + 1] = math.random(0, 1) == 1 and "1" or "0"
                    end
                    pcall(vim.api.nvim_buf_set_extmark, buf, glitch_ns, top + i, 0, {
                      end_col = len,
                      virt_text = { { table.concat(rand), "HackermanGlitch" } },
                      virt_text_pos = "overlay",
                      priority = 300,
                    })
                  end
                end
              end

              wave_pos = wave_pos + wave_speed
            end)
          )
        end,
      })

      -- ════════════════════════════════════════════════════
      -- ██  INTRUSION DETECTED (first LSP error per buffer)
      -- ════════════════════════════════════════════════════

      local intrusion_shown = {}

      vim.api.nvim_create_autocmd("DiagnosticChanged", {
        callback = function(args)
          if not is_hackerman() then
            return
          end
          local buf = args.buf
          if not buf or intrusion_shown[buf] then
            return
          end
          if not is_code_buf(buf) then
            return
          end

          local errors = vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.ERROR })
          if #errors == 0 then
            return
          end

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
            "   █   threat: critical             █   ",
            "   █                                █   ",
            "   ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀   ",
            "                                        ",
          }

          local float_buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, msg_lines)

          local hl_ns = vim.api.nvim_create_namespace("hackerman_intrusion_hl")
          for i = 0, #msg_lines - 1 do
            local hl = "HackermanIntrusion"
            if i == 3 then
              hl = "HackermanIntrusionTitle"
            end
            if i >= 5 and i <= 7 then
              hl = "HackermanIntrusionText"
            end
            if i == 1 or i == 9 then
              hl = "HackermanIntrusionBorder"
            end
            vim.api.nvim_buf_set_extmark(float_buf, hl_ns, i, 0, {
              line_hl_group = hl,
              end_row = i + 1,
            })
          end

          local width = 40
          local height = #msg_lines
          local float_win = vim.api.nvim_open_win(float_buf, false, {
            relative = "editor",
            width = width,
            height = height,
            col = math.floor((vim.o.columns - width) / 2),
            row = math.floor((vim.o.lines - height) / 2),
            style = "minimal",
            border = "none",
            zindex = 200,
          })
          vim.api.nvim_set_option_value("winhl", "Normal:HackermanIntrusion", { win = float_win })

          vim.defer_fn(function()
            if vim.api.nvim_win_is_valid(float_win) then
              vim.api.nvim_set_option_value("winblend", 10, { win = float_win })
            end
          end, 300)

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

      vim.api.nvim_create_autocmd("BufWipeout", {
        callback = function(args)
          intrusion_shown[args.buf] = nil
        end,
      })

    end,
  },
}
