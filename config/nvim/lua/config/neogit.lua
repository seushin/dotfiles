local neogit = require("neogit")
local util = require("util")

neogit.setup({
  disable_commit_confirmation = true,
  signs = {
    -- { CLOSED, OPENED }
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
  },
})

-- git status
util.nnoremap("<leader>gs", ":Neogit<CR>")
