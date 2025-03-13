local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

-- Schema:
-- {
--   buf = 10,
--   data = {
--     adapter = {
--       formatted_name = "Copilot",
--       model = "o3-mini-2025-01-31",
--       name = "copilot"
--     },
--     bufnr = 10,
--     id = 6107753,
--     strategy = "chat"
--   },
--   event = "User",
--   file = "CodeCompanionRequestStarted",
--   group = 14,
--   id = 30,
--   match = "CodeCompanionRequestStarted"
-- }
--
-- CodeCompanionRequestFinished also has a status field

vim.api.nvim_create_autocmd(
    {"User"},
    {
        pattern = "CodeCompanion*",
        group = group,
        callback = function(request)
            if request.match == "CodeCompanionInlineFinished" then
                -- print(request.buf)
                -- vim.cmd("stopinsert")
                vim.cmd("w")
            end
        end
    }
)

local timer = nil
local delay = 500 -- milliseconds

local function save_buffer()
  vim.cmd("silent! write")
  vim.cmd("q")
end

vim.api.nvim_create_autocmd("TextChanged", {
  pattern = "*",
  callback = function()
    if timer then
      timer:stop()
    end
    timer = vim.loop.new_timer()
    timer:start(delay, 0, function()
      vim.schedule(save_buffer)
      timer:stop()
      timer:close()
      timer = nil
    end)
  end,
})

