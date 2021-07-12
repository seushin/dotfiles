local neogit = require("neogit")

neogit.setup({
  disable_commit_confirmation = true,
  signs = {
    -- { CLOSED, OPENED }
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
  },
})
