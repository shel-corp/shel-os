local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- Plug 'neovim/nvim-lspconfig'
-- Plug 'github/copilot.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'olimorris/codecompanion.nvim'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'} )
Plug 'MeanderingProgrammer/render-markdown.nvim'

vim.call('plug#end')

require('code-companion')
