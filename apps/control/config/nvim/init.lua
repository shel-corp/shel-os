local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- "Dashboard"
-- Plug 'github/copilot.vim'

Plug 'nvim-lua/plenary.nvim'


-- "LLM"
Plug 'olimorris/codecompanion.nvim'

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'} )
Plug 'MeanderingProgrammer/render-markdown.nvim'

-- "LSP"
-- Plug 'neovim/nvim-lspconfig'

-- "Github"
-- Plug 'ldelossa/litee.nvim'
-- Plug('ldelossa/gh.nvim', { requires = {'ldelossa/litee.nvim'} })

vim.call('plug#end')

require('code-companion')
