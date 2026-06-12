vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = function()
    local file = io.open(vim.fn.expand("~/.config/theme/state"), "r")
    if not file then
      vim.notify("Could not read theme file:", vim.log.levels.WARN)
      return
    end

    local mode = file:read("*a")
    file:close()

    mode = mode:gsub("%s+", "")
    if not mode == "dark" or not mode == "light" then
      vim.notify("Invalid theme value: " .. mode, vim.log.levels.WARN)
      return
    end
    vim.o.background = mode
    vim.cmd("redraw")
  end,
})
