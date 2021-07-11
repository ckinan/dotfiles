call plug#begin()
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

" Search in content only with :Ag ttps://github.com/junegunn/fzf.vim/issues/346#issuecomment-288483704
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Search in content only with :Rg https://github.com/junegunn/fzf.vim/issues/714#issuecomment-428802659
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

