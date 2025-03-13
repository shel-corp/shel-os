-- inputs:
-- .ex module and a test to run
-- prompt with: Can you audit this file for potential issues, optimizations, or improvements?
-- step through the improvements and implement them
-- run the test to verify the improvements
-- repeat until all improvements are implemented

-- Are there code paths that are not tested?

constants = {USER_ROLE = "user", SYSTEM_ROLE = "system"}
prompt_library = {
    ["Commit workflow"] = {
        strategy = "chat",
        description = "Generate a commit message",
        opts = {
            index = 10,
            is_default = true,
            is_slash_cmd = true,
            short_name = "gen_chat_commit",
            auto_submit = true
        },
        prompts = {
            {
                role = constants.USER_ROLE,
                content = function()
                    vim.g.codecompanion_auto_tool_mode = true
                    return string.format(
                        [[You are an expert at following the Conventional Commit specification. 

Given the git diff listed below, please generate a commit message for me.
Then use the using the @editor tool to write the commit message to the file <file>%s</file>

```diff
%s
```
]],
                        vim.fn.system("~/.dotfiles/scripts/commit_dir.sh"),
                        vim.fn.system("git diff --no-ext-diff --staged")
                    )
                end,
                opts = {
                    contains_code = true
                }
            }
        }
    },
    ["Credo Workflow"] = {
        strategy = "chat",
        description = "Fix Credo issues",
        opts = {
            index = 10,
            is_default = true,
            is_slash_cmd = true,
            short_name = "fix_credo",
            auto_submit = true
        },
        prompts = {
            {
                role = constants.USER_ROLE,
                content = function()
                    vim.g.codecompanion_auto_tool_mode = true
                    return 
                        [[
## Me

### Instructions

Your instructions here

### Steps to Follow

You are required to write code following the instructions provided above and test the correctness by running the designated test suite. Follow these steps exactly:

1. Then use the @cmd_runner tool to run the lint suite with `mix credo` 
2. Using the @editor tool, update the update the /files with the changes suggested by the lint suite
3. Then use the @cmd_runner tool to run the lint suite with `mix credo` (do this after you have updated the code)
4. Make sure you trigger both tools in the same response

We'll repeat this cycle until the tests pass. Ensure no deviations from these steps.

]]
                   
                end,
                opts = {
                    contains_code = true
                }
            }
        }
    },
    ["Generate a Commit Message"] = {
        strategy = "inline",
        description = "Generate a commit message",
        opts = {
            index = 10,
            is_default = true,
            is_slash_cmd = true,
            short_name = "gen_commit",
            auto_submit = true
        },
        prompts = {
            {
                role = constants.USER_ROLE,
                content = function()
                    return string.format(
                        [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
%s
```
]],
                        vim.fn.system("git diff --no-ext-diff --staged")
                    )
                end,
                opts = {
                    contains_code = true
                }
            }
        }
    },
    ["Generate a PR description"] = {
        strategy = "inline",
        description = "Generate a PR description",
        opts = {
            index = 10,
            is_default = true,
            is_slash_cmd = true,
            short_name = "gen_pr",
            auto_submit = true
        },
        prompts = {
            {
                role = constants.USER_ROLE,
                content = function()
                    return string.format(
                        [[You are an expert at following the Conventional github pull request description specification. Given the github pull request template, jira ticket, and git diff listed below, please generate a pull request description for me:
**Jira ticket**
```
%s
```
**Pull request template**
```markdown
%s
```

**Branch diff**
```diff
%s
```
]],
                        vim.fn.system(
                            "echo $(git rev-parse --abbrev-ref HEAD | awk -F'-' '{print $NF}' | xargs -t -I{} jira issues view SQUAL-{})"
                        ),
                        vim.fn.system("cat ~/.config/github/templates/pull_request_template.md"),
                        vim.fn.system("git log -p main..$(git branch --show-current) 2>&1")
                    )
                end,
                opts = {
                    contains_code = true
                }
            }
        }
    }
}

require("codecompanion").setup(
    {
        prompt_library = prompt_library,
        strategies = {
          chat = {
            slash_commands = {
              ["file"] = {
                -- Location to the slash command in CodeCompanion
                  callback = "strategies.chat.slash_commands.file",
                  description = "Select a file using Telescope",
                  opts = {
                    provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                  },
              },
            },
          },
        },
        display = {
            action_palette = {
                width = 95,
                height = 10,
                prompt = "Prompt ", -- Prompt used for interactive LLM calls
                provider = "telescope", -- default|telescope|mini_pick
                opts = {
                    show_default_actions = true, -- Show the default actions in the action palette?
                    show_default_prompt_library = true -- Show the default prompt library in the action palette?
                }
            },
            diff = {
                enabled = false
            }
        },
        chat = {
            agents = {
                ["my_agent"] = {
                    description = "A custom agent combining tools",
                    system_prompt = "Describe what the agent should do",
                    tools = {
                        "cmd_runner",
                        "editor"
                        -- Add your own tools or reuse existing ones
                    }
                }
            },
            tools = {
                ["my_tool"] = {
                    description = "Run a custom task",
                    callback = function(command)
                        -- Perform the custom task here
                        return "Tool result"
                    end
                }
            }
        },
        opts = {
            log_level = "DEBUG"
        },
        adapters = {
            gemini = function()
                return require("codecompanion.adapters").extend(
                    "gemini",
                    {
                        env = {
                            api_key = "cmd:echo $GEMINI_API_TOKEN"
                        }
                    }
                )
            end
        }
    }
)
