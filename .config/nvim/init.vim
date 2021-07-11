call plug#begin()
" LSP
Plug 'mfussenegger/nvim-jdtls'
" Smooth scroll
" Plug 'karb94/neoscroll.nvim'
" Show scrollbar line in the right side
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
" Tree: https://github.com/kyazdani42/nvim-tree.lua
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" Tabs: https://github.com/romgrk/barbar.nvim
Plug 'romgrk/barbar.nvim'
" Theme: https://github.com/morhetz/gruvbox
Plug 'morhetz/gruvbox'
" Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Autocompletion
Plug 'hrsh7th/nvim-compe'
call plug#end()

" ****
" General
" ****
" Show line numbers
set number

" Clipboard. See :help clipboard
set clipboard+=unnamedplus

" Set <leader> key to comma
let mapleader = "," 

" Mouse: https://neovim.io/doc/user/options.html#'mouse'
set mouse=a

" ****
" Tree
" ****
let g:nvim_tree_auto_open = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_tab_open = 1
let g:nvim_tree_lsp_diagnostics = 1

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

set termguicolors " this variable must be enabled for colors to be applied properly

" ****
" Theme
" ****

autocmd vimenter * ++nested colorscheme gruvbox
set background=dark

" ****
" Search
" ****

" Respect .gitignore: https://github.com/junegunn/fzf.vim/issues/121#issuecomment-209534405
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Search in content only with :Ag https://github.com/junegunn/fzf.vim/issues/346#issuecomment-655446292
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" Search in content only with :Rg https://github.com/junegunn/fzf.vim/issues/714#issuecomment-428802659
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)


" ****
" LSP
" ****

" https://github.com/mfussenegger/nvim-jdtls#language-server-installation
if has('nvim-0.5')
  augroup lsp
    au!
    au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}})
  augroup end
endif

nnoremap <space>ca <Cmd>lua require('jdtls').code_action()<CR>
nnoremap <space>r <Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>
nnoremap gD <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gd <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap K <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gi <Cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap gr <Cmd>lua vim.lsp.buf.references()<CR>
nnoremap ic <Cmd>lua vim.lsp.buf.incoming_calls()<CR>

" ****
" Autocompletion
" ****

" https://github.com/hrsh7th/nvim-compe#prerequisite
set completeopt=menuone,noselect

" https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF



