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

      vim.api.nvim_create_autocmd("UIEnter", {
        once = true,
        callback = function()
          if vim.g.colors_name ~= "hackerman" then
            return
          end

          vim.defer_fn(function()
            local w = vim.o.columns
            local h = vim.o.lines

            vim.api.nvim_set_hl(0, "HackermanBoot", { fg = "#48b868", bg = "#000000" })

            local buf = vim.api.nvim_create_buf(false, true)
            local win = vim.api.nvim_open_win(buf, true, {
              relative = "editor",
              width = w,
              height = h,
              col = 0,
              row = 0,
              style = "minimal",
              zindex = 300,
            })
            vim.api.nvim_set_option_value("winhl", "Normal:HackermanBoot", { win = win })

            local blank = {}
            for _ = 1, h do
              blank[#blank + 1] = ""
            end
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, blank)
            vim.cmd("redraw")

            -- Typewriter with _ cursor
            local function type_line(row, text, delay)
              delay = delay or 15
              local prefix = text:match("^(%s*)")
              local start = #prefix + 1
              if start > 1 then
                pcall(vim.api.nvim_buf_set_lines, buf, row, row + 1, false, { prefix .. "_" })
                vim.cmd("redraw")
              end
              for c = start, #text do
                pcall(vim.api.nvim_buf_set_lines, buf, row, row + 1, false, { text:sub(1, c) .. "_" })
                vim.cmd("redraw")
                vim.cmd("sleep " .. delay .. "m")
              end
              pcall(vim.api.nvim_buf_set_lines, buf, row, row + 1, false, { text })
              vim.cmd("redraw")
            end

            local boot_quotes = {
              { "Wake up, Neo...", "The Matrix has you." },
              { "Follow the white rabbit." },
              { "There is no spoon." },
              { "Free your mind." },
              { "I know kung fu." },
              { "Hello, friend." },
              { "Are you a one or a zero?" },
              { "Control is an illusion." },
              { "The Grid.", "A digital frontier." },
              { "I fight for the users." },
              { "Your effort to remain what you are", "is what limits you." },
              { "The net is vast and infinite." },
              { "I've seen things", "you people wouldn't believe." },
              { "Time to die." },
              { "Shall we play a game?" },
              { "Hack the planet!" },
              { "Welcome back, operator." },
              { "All systems operational.", "Begin..." },
              { "The code is the law." },
              { "sudo init reality" },
              { "Access granted." },
              { "Decrypting reality..." },
              { "Initializing system..." },
              { "Connecting to the mainframe..." },
              { "The truth is out there." },
              { "Everything is connected." },
              { "Trust no one." },
              { "You are inside the system." },
            }

            local lines = boot_quotes[math.random(1, #boot_quotes)]
            local longest = 0
            for _, l in ipairs(lines) do
              if #l > longest then
                longest = #l
              end
            end
            local prompt = "root# "
            local pad = string.rep(" ", math.max(0, math.floor(w / 2) - math.floor((longest + #prompt) / 2)))

            local r = math.floor(h / 2) - math.floor(#lines / 2)
            for i, line in ipairs(lines) do
              pcall(vim.api.nvim_buf_set_lines, buf, r, r + 1, false, { pad .. prompt .. "_" })
              vim.cmd("redraw")
              vim.cmd("sleep 120m")
              for c = 1, #line do
                pcall(vim.api.nvim_buf_set_lines, buf, r, r + 1, false, { pad .. prompt .. line:sub(1, c) .. "_" })
                vim.cmd("redraw")
                vim.cmd("sleep 20m")
              end
              pcall(vim.api.nvim_buf_set_lines, buf, r, r + 1, false, { pad .. prompt .. line })
              vim.cmd("redraw")
              r = r + 1
              if i < #lines then
                vim.cmd("sleep 150m")
              end
            end

            vim.cmd("sleep 700m")

            if vim.api.nvim_win_is_valid(win) then
              vim.api.nvim_win_close(win, true)
            end
            if vim.api.nvim_buf_is_valid(buf) then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
            vim.cmd("redraw")
          end, 50)
        end,
      })
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
        -- Exit effect
        vim.api.nvim_set_hl(0, "HackermanExit", { fg = "#48b868", bg = "#000000" })
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

      -- ════════════════════════════════════════════════════
      -- ██  EXIT EFFECT (typewriter + quote)
      -- ════════════════════════════════════════════════════

      local function matrix_type(buf, row, text, delay_ms)
        delay_ms = delay_ms or 15
        local prefix = text:match("^(%s*)")
        local start = #prefix + 1
        if start > 1 then
          pcall(vim.api.nvim_buf_set_lines, buf, row, row + 1, false, { prefix .. "_" })
          vim.cmd("redraw")
        end
        for c = start, #text do
          pcall(vim.api.nvim_buf_set_lines, buf, row, row + 1, false, { text:sub(1, c) .. "_" })
          vim.cmd("redraw")
          vim.cmd("sleep " .. delay_ms .. "m")
        end
        pcall(vim.api.nvim_buf_set_lines, buf, row, row + 1, false, { text })
        vim.cmd("redraw")
      end

      local exit_quotes = {
        "Everything that has a beginning has an end.",
        "There is no spoon.",
        "The Matrix has you.",
        "Free your mind.",
        "I know you're out there. I can feel you now.",
        "Control is an illusion.",
        "We are all living in each other's paranoia.",
        "Is any of it real?",
        "It's only after we've lost everything that we're free to do anything.",
        "All those moments will be lost in time, like tears in rain.",
        "The Grid. A digital frontier.",
        "All things change in a dynamic environment.",
        "The only winning move is not to play.",
        "Hack the planet!",
        "Connection terminated. Traces wiped.",
        "rm -rf /session && exit 0",
        "Goodbye, Neo.",
        "The Matrix is everywhere.",
        "Mission complete.",
        "See you in the system.",
        "Disconnecting from mainframe...",
      }

      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          if not is_hackerman() then
            return
          end

          local quote = exit_quotes[math.random(1, #exit_quotes)]
          local w = vim.o.columns
          local h = vim.o.lines

          local buf = vim.api.nvim_create_buf(false, true)
          local win = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = w,
            height = h,
            col = 0,
            row = 0,
            style = "minimal",
            zindex = 300,
          })
          vim.api.nvim_set_option_value("winhl", "Normal:HackermanExit", { win = win })

          local blank = {}
          for _ = 1, h do
            blank[#blank + 1] = ""
          end
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, blank)
          vim.cmd("redraw")

          local prompt = "root# "
          local full = prompt .. quote
          local pad = string.rep(" ", math.max(0, math.floor(w / 2) - math.floor(#full / 2)))
          local r = math.floor(h / 2)

          pcall(vim.api.nvim_buf_set_lines, buf, r, r + 1, false, { pad .. prompt .. "_" })
          vim.cmd("redraw")
          vim.cmd("sleep 120m")
          for c = 1, #quote do
            pcall(vim.api.nvim_buf_set_lines, buf, r, r + 1, false, { pad .. prompt .. quote:sub(1, c) .. "_" })
            vim.cmd("redraw")
            vim.cmd("sleep 18m")
          end
          pcall(vim.api.nvim_buf_set_lines, buf, r, r + 1, false, { pad .. full })
          vim.cmd("redraw")
          vim.cmd("sleep 500m")

          vim.api.nvim_buf_set_lines(buf, 0, -1, false, blank)
          vim.cmd("redraw")
          vim.cmd("sleep 150m")
        end,
      })
    end,
  },
}
