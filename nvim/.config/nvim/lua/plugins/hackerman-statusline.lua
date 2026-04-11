-- Hackerman Statusline: rotating hacker quotes
-- Only active when colorscheme is "hackerman"

local quotes = {
  "The Matrix has you...",
  "Follow the white rabbit",
  "Wake up, Neo...",
  "There is no spoon",
  "I know kung fu",
  "Hack the planet!",
  "I'm in.",
  "Access granted",
  "root@localhost:~#",
  "Connection encrypted",
  "Bypassing firewall...",
  "Injecting payload...",
  "Buffer overflow detected",
  "Kernel panic averted",
  "Decrypting traffic...",
  "Proxy chain established",
  "Signal intercepted",
  "Backdoor installed",
  "Packet sniffing...",
  "Zero-day loaded",
  "Tor circuit built",
  "SSH tunnel active",
  "Polymorphic code ready",
  "Traces wiped",
  "Ghost in the machine",
  "Mr. Robot was here",
  "Control is an illusion",
  "We are fsociety",
  "Every system has a flaw",
  "Trust no one",
  "Big Brother is watching",
  "// TODO: hack the mainframe",
  "sudo rm -rf /doubt",
  "while(alive) { code(); }",
  "chmod 777 /world",
  "> ping reality",
  "Segfault in the Matrix",
  "Compiling humanity...",
  "404: Sleep not found",
  "Overflow the stack, overflow the world",
}

local current_quote = quotes[math.random(1, #quotes)]

-- Rotate quote every 30 seconds
local quote_timer = vim.uv.new_timer()
quote_timer:start(
  30000,
  30000,
  vim.schedule_wrap(function()
    current_quote = quotes[math.random(1, #quotes)]
  end)
)

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      if not opts.sections then
        return
      end

      table.insert(opts.sections.lualine_x, 1, {
        function()
          return current_quote
        end,
        cond = function()
          return vim.g.colors_name == "hackerman"
        end,
        color = { fg = "#526e58", italic = true },
      })
    end,
  },
}
