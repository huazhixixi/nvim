" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" Author: fock of @theniceboy with my private modifiactons

" This is the minimal version


" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ====================
" === Editor Setup ===
" ====================

" ===
" === System
" ===
"set clipboard=unnamed
let &t_ut=''
set autochdir


" ===
" === Editor behavior
" ===
set number
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu
set hlsearch
set incsearch
set ignorecase
set smartcase
set encoding=utf-8
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=30
set tw=0
set indentexpr=
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
set autoindent
set laststatus=2
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set shortmess+=c
set inccommand=split
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set regexpengine=1
set visualbell
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
    set undofile
    set undodir=~/.config/nvim/tmp/undo,.
endif
set colorcolumn=80
set updatetime=1000
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Terminal Behavior
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
let g:terminal_color_0   = '#000000'
let g:terminal_color_1   = '#FF5555'
let g:terminal_color_2   = '#50FA7B'
let g:terminal_color_3   = '#F1FA8C'
let g:terminal_color_4   = '#BD93F9'
let g:terminal_color_5   = '#FF79C6'
let g:terminal_color_6   = '#8BE9FD'
let g:terminal_color_7   = '#BFBFBF'
let g:terminal_color_8   = '#4D4D4D'
let g:terminal_color_9   = '#FF6E67'
let g:terminal_color_10  = '#5AF78E'
let g:terminal_color_11  = '#F4F99D'
let g:terminal_color_12  = '#CAA9FA'
let g:terminal_color_13  = '#FF92D0'
let g:terminal_color_14  = '#9AEDFE'


" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "

" Save & quit
noremap q :q!<CR>
noremap Q :qa!<CR>
noremap w :w!<CR>
noremap W :w!<CR>

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>


" ===
" === Cursor Movement
" ===
noremap <silent> K 5k
noremap <silent> J 5j
noremap <silent> H b
noremap <silent> L w
noremap <silent> <C-h> ^
noremap <silent> <C-l> $


" ===
" === Window management
" ===
" Disable the default s key
noremap s <nop>
" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap spk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap spj :set splitbelow<CR>:split<CR>
noremap sph :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap spl :set splitright<CR>:vsplit<CR>
noremap smv <C-w>t<C-w>K
noremap smh <C-w>t<C-w>H
" moving the cursor around windows
noremap ss <C-w>w
noremap sk <C-w>k
noremap sj <C-w>j
noremap sh <C-w>h
noremap sl <C-w>l
noremap <Up> :res +5<CR>
noremap <Down> :res -5<CR>
noremap <Left> :vertical resize-5<CR>
noremap <Right> :vertical resize+5<CR>
" tab management
noremap stt :tabe<CR>
noremap sth :-tabnext<CR>
noremap stl :+tabnext<CR>
noremap stmh :-tabmove<CR>
noremap stml :+tabmove<CR>


" ===
" === Other useful stuff
" ===
" Opening a terminal window
noremap <LEADER>/ :term<CR>

" Open up lazygit
noremap <LEADER>lg :term lazygit<CR>

" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" find and replace
noremap \s :%s//g<left><left>

" Compile function
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        set splitbelow
        exec "!g++ -std=c++11 % -Wall -o %<"
        :sp
        :res -15
        :term ./%<
    elseif &filetype == 'python'
        set splitbelow
        :sp
        :term python3 %
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'html'
        silent! exec "!".g:mkdp_browser." % &"
    elseif &filetype == 'go'
        set splitbelow
        :sp
        :term go run %
    endif
endfunc


" ===
" === Install Plugins with Vim-Plug
" ===
call plug#begin('~/.config/nvim/plugged')

Plug 'doums/darcula'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'lambdalisue/suda.vim' " 使用 :sudow 以root身份保存文件

call plug#end()


" ===================== Start of Plugin Settings =====================

" ===
" === theme
" ===
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
syntax on
set background=dark " Setting dark mode
colorscheme darcula


" ===
" === lightline
" ===
let g:lightline = { 'colorscheme': 'darculaOriginal' }


" ===
" === coc
" ===
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
let g:coc_global_extensions = [
            \ 'coc-python',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-css',
            \ 'coc-phpls',
            \ 'coc-lists',
            \ 'coc-tsserver',
            \ 'coc-emmet',
            \ 'coc-vetur',
            \ 'coc-yank',
            \ 'coc-git',
            \ 'coc-gitignore',
            \ 'coc-explorer',
            \ 'coc-translator',
            \ 'coc-snippets',
            \ 'coc-highlight',
            \ 'coc-pairs']
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use LEADER k to show documentation in preview window
nnoremap <silent> <f1> :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Useful commands
" coc-explorer
nmap tt :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)
" coc-yank
nnoremap <silent> <LEADER>y :<C-u>CocList -A --normal yank<cr>
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


" ===
" === vim-go
" ===
let g:go_auto_type_info                      = 1
let g:go_highlight_array_whitespace_error    = 1
let g:go_highlight_build_constraints         = 1
let g:go_highlight_chan_whitespace_error     = 1
let g:go_highlight_extra_types               = 1
let g:go_highlight_fields                    = 1
let g:go_highlight_format_strings            = 1
let g:go_highlight_function_calls            = 1
let g:go_highlight_function_parameters       = 1
let g:go_highlight_functions                 = 1
let g:go_highlight_generate_tags             = 1
let g:go_highlight_methods                   = 1
let g:go_highlight_operators                 = 1
let g:go_highlight_space_tab_error           = 1
let g:go_highlight_string_spellcheck         = 1
let g:go_highlight_structs                   = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types                     = 1
let g:go_def_mapping_enabled                 = 0
let g:go_doc_keywordprg_enabled              = 0
autocmd FileType go noremap gk :GoDoc<CR>
autocmd FileType go noremap gta :GoTest<CR>
autocmd FileTYpe go noremap gtt :GoTestFunc<CR>


" ===================== End of Plugin Settings =====================

" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim

" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
	exec "e ~/.config/nvim/_machine_specific.vim"
endif

" ===
" === Necessary Commands to Execute
" ===
exec "nohlsearch"
