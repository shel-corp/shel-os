local path = debug.getinfo(1, "S").source:match("@?(.*/)")
local old_stdpath = vim.fn.stdpath

print(path)
print(old_stdpath("config"))
vim.fn.stdpath = function(value)
    print(value)
    return old_stdpath(value)
end

local rtp = vim.api.nvim_list_runtime_paths()
print("Runtime paths:" .. vim.inspect(rtp))

    print("END Runtime paths:")
