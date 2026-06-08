local crt_u_cmd = vim.api.nvim_create_user_command

crt_u_cmd("CopyAbsolutePath", function () vim.fn.setreg("+", vim.fn.expand("%:p")) end, {})
crt_u_cmd("CopyRelativePath", function () vim.fn.setreg("+", vim.fn.expand("%:.")) end, {})
