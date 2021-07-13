local function lsp_progress()
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

local function sub_home_dir(path)
  local home = os.getenv("HOME")
  local _, index = string.find(path, home, 1)
  if index ~= nil and index ~= string.len(path) then
    return string.gsub(path, home, '~')
  end
  return path
end

local function get_file_icon(path)
  if path == "" then
    return ""
  end
  local bufnr = vim.api.nvim_buf_get_number(0)
  local name = vim.api.nvim_buf_get_name(bufnr)
  local extension = vim.fn.fnamemodify(name, ':e')

  return require("nvim-web-devicons").get_icon(name, extension, { default = true })
end

local function get_cur_file()
  local path = vim.api.nvim_call_function("expand", { "%F" })
  local icon = get_file_icon(path) or " "
  path = sub_home_dir(path)
  return icon .. " " .. path
end

vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])

local config = {
  options = {
    theme = "gruvbox",
    section_separators = { " ", " " },
    component_separators = { " ", " " },
    icons_enabled = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { { "diagnostics", sources = { "nvim_lsp" } }, get_cur_file },
    lualine_x = { "filetype", lsp_progress },
    lualine_y = {},
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree" },
}

-- try to load matching lualine theme

local M = {}

function M.load()
  local name = vim.g.colors_name or ""
  local ok, _ = pcall(require, "lualine.themes." .. name)
  if ok then
    config.options.theme = name
  end
  require("lualine").setup(config)
end

M.load()

return M
