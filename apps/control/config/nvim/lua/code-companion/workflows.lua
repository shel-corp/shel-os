local fmt = string.format

local constants = {
    LLM_ROLE = "llm",
    USER_ROLE = "user",
    SYSTEM_ROLE = "system"
}

-- Get current branch commits against main
--  git cherry -v main $\(git branch list --show-current\) | cut -d' ' -f2
---@return string
get_branch_commit_shas = function()
    local handle = io.popen("git cherry -v main $(git branch --show-current) | cut -d' ' -f2")
    local result = handle:read("*a")
    handle:close()
    return result
end

get_branch_diff = function()
    local handle = io.popen("git log -p main..$(git branch --show-current) 2>&1")
    local result = handle:read("*a")
    handle:close()
    if result == "" then
        return "No differences found or an error occurred."
    end
    return result
end

---@return string
get_repo_root = function()
    local handle = io.popen("git ref-parse --show-toplevel")
    local result = handle:read("*a")
    handle:close()
    return result
end


workflows = {
    ["PR description"] = {
        strategy = "workflow",
        description = "Use a workflow to generate a PR description",
        opts = {
            index = 4,
            is_default = true,
            short_name = "pr_desc",
        },
        prompts = {
            {
                {
                    name = "Setup Test",
                    role = constants.USER_ROLE,
                    opts = {auto_submit = false},
                    content = function()
                        -- Enable turbo mode!!!
                        vim.g.codecompanion_auto_tool_mode = true

                        return [[### Instructions

Your instructions here

### Steps to Follow

You are required to write code following the instructions provided above and test the correctness by running the designated test suite. Follow these steps exactly:

1. Update the code in #buffer{watch} using the @editor tool
2. Then use the @cmd_runner tool to run the test suite with `<test_cmd>` (do this after you have updated the code)
3. Make sure you trigger both tools in the same response

We'll repeat this cycle until the tests pass. Ensure no deviations from these steps.]]
                    end
                }
            },
            {
                {
                    name = "Repeat On Failure",
                    role = constants.USER_ROLE,
                    opts = {auto_submit = true},
                    -- Scope this prompt to the cmd_runner tool
                    condition = function()
                        return vim.g.codecompanion_current_tool == "cmd_runner"
                    end,
                    -- Repeat until the tests pass, as indicated by the testing flag
                    -- which the cmd_runner tool sets on the chat buffer
                    repeat_until = function(chat)
                        return chat.tool_flags.testing == true
                    end,
                    content = "The tests have failed. Can you edit the buffer and run the test suite again?"
                }
            }
        }
    }
}
