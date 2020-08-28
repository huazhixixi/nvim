" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" Author: fock of @theniceboy with my private modifiactons


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
" === Terminal Behaviors
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'


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

" ESC
onoremap <A-n> <ESC><ESC>
inoremap <A-n> <ESC><ESC>
cnoremap <A-n> <ESC><ESC>


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
    elseif &filetype == 'rust'
        exec "!rustc % -o %<"
        exec "!time ./%<"
    endif
endfunc


" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')

" Pretty Dress
"Plug 'morhetz/gruvbox'
"Plug 'srcery-colors/srcery-vim'
"Plug 'ajmwagar/vim-deus'
"Plug 'doums/darcula'
"Plug 'connorholyday/vim-snazzy'
"Plug 'sickill/vim-monokai'
"Plug 'NLKNguyen/papercolor-theme'
Plug 'liuchengxu/space-vim-theme'
Plug 'liuchengxu/eleline.vim'
"Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'

" File navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'pechorin/any-jump.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Bookmarks
Plug 'MattesGroeger/vim-bookmarks'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'

" Genreal Highlighter
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'RRethy/vim-illuminate'

" Taglist
Plug 'liuchengxu/vista.vim'

" Undo Tree
Plug 'mbbill/undotree'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'dkarter/bullets.vim'
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }

" HTML, CSS, JavaScript, JSON, etc.
Plug 'elzr/vim-json'
Plug 'othree/html5.vim'
Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }

" Rust
Plug 'rust-lang/rust.vim'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'tweekmonster/braceless.vim'

" Debuger
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-python --enable-go --enable-bash'}

" Editor Enhancement
Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdcommenter'
Plug 'lambdalisue/suda.vim' " 使用 :sudow 以root身份保存文件
Plug 'sheerun/vim-polyglot'
Plug 'godlygeek/tabular'

" Vim Applications
Plug 'itchyny/calendar.vim'

" Other
Plug 'wincent/terminus'
Plug 'luochen1990/rainbow'
Plug 'mg979/vim-xtabline'

call plug#end()

" ===================== Start of Plugin Settings =====================

" ===
" === Dress up my vim
" ===
syntax on
set termguicolors
set background=dark " Setting dark mode
"colorscheme gruvbox
"colorscheme darcula
"colorscheme deus
"colorscheme srcery
"colorscheme snazzy
"colorscheme monokai
"colorscheme PaperColor
colorscheme space_vim_theme


" ===
" === 背景透明
" ===
"hi Normal     ctermbg=NONE guibg=NONE
"hi LineNr     ctermbg=NONE guibg=NONE
"hi SignColumn ctermbg=NONE guibg=NONE


" ===
" === 灰色注释
" ===
hi Comment guifg=#5C6370 ctermfg=59


" ===
" === eleline
" ===
let g:eleline_powerline_fonts = 1
let g:eleline_slim = 1


" ===
" === lightline
" ===
"let g:lightline = { 'colorscheme': 'gruvbox' }
"let g:lightline = { 'colorscheme': 'darculaOriginal' }
"let g:lightline = { 'colorscheme': 'deus' }
"let g:lightline = { 'colorscheme': 'srcery' }
"let g:lightline = { 'colorscheme': 'snazzy' }
"let g:lightline = { 'colorscheme': 'PaperColor' }
"let g:lightline = { 'colorscheme': 'space_vim_theme' }


" ===
" === Colorizer
" ===
let g:colorizer_syntax = 1


" ===
" === rainbow
" ===
let g:rainbow_active = 1


" ===
" === GitGutter
" ===
let g:gitgutter_signs = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 0
autocmd BufWritePost * GitGutter
nnoremap gf :GitGutterFold<CR>
nnoremap gh :GitGutterPreviewHunk<CR>
nnoremap gk :GitGutterPrevHunk<CR>
nnoremap gj :GitGutterNextHunk<CR>

" ===
" === vimagit
" ===
noremap mg :Magit<CR>


" ===
" === tabular
" ===
vmap ga :Tabularize /


" ===
" === xtabline, 这个插件其实我也不清楚到底有什么实际作用
" ===
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
noremap to :XTabMode<CR>


" ===
" === any-jump
" ===
nnoremap fj :AnyJump<CR>
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9


" ===
" === Undotree
" ===
noremap U :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeNextState
    nmap <buffer> j <plug>UndotreePreviousState
    nmap <buffer> K 5<plug>UndotreeNextState
    nmap <buffer> J 5<plug>UndotreePreviousState
endfunc


" ===
" === vimspector
" ===
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
    " has to be a function to avoid the extra space fzf#run insers otherwise
    execute '0r ~/.config/nvim/vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
            \   'source': 'ls -1 ~/.config/nvim/vimspector_json',
            \   'down': 20,
            \   'sink': function('<sid>read_template_into_buffer')
            \ })
noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=🛑 texthl=Normal
sign define vimspectorBPDisabled text=🚫 texthl=Normal
sign define vimspectorPC text=👉 texthl=SpellBad


" ===
" === vim-easymotion
" ===
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_smartcase = 1
" Move to {char}
map  fn <Plug>(easymotion-bd-f)
nmap fn <Plug>(easymotion-overwin-f)
" Move to line
map fl <Plug>(easymotion-bd-jk)
nmap fl <Plug>(easymotion-overwin-line)


" ===
" === suda.vim
" ===
cnoreabbrev sudow w suda://%


" ===
" === Python-syntax
" ===
let g:python_highlight_all = 1


" ===
" === coc
" ===
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
let g:coc_global_extensions = [
            \ 'coc-python',
            \ 'coc-rls',
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

" Use <C-j> and <C-k> to navigate the completion list:
inoremap <C-j> <nop>
inoremap <C-k> <nop>
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
nnoremap tt :CocCommand explorer<CR>
" coc-yank
nnoremap <silent> <LEADER>y :<C-u>CocList -A --normal yank<cr>
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1
            \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'


" ===
" === vim-table-mode
" ===
noremap <LEADER>mtm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'


" ===
" === Markdown Settings
" ===
" Snippets
source ~/.config/nvim/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell


" ===
" === Bullets.vim
" ===
"let g:bullets_set_mappings = 0
let g:bullets_enabled_file_types = [
            \ 'markdown',
            \ 'text',
            \ 'gitcommit',
            \ 'scratch'
            \]


" ===
" === vim-markdown-toc, :GenToGFM 生成目录, :RmoveToc 删除目录, :UpdateToc 手动更新目录
" ===
let g:vmt_auto_update_on_save = 1
let g:vmt_dont_insert_fence = 0
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'


" ===
" === FZF
" ===
" Layout
let g:fzf_layout =
\ {'up':'~90%', 'window':
    \ {
        \ 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5,
        \ 'highlight': 'Todo', 'border': 'sharp'
    \ }
\ }

" Color
let g:fzf_colors =
\ {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment']
\ }

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
let g:fzf_buffers_jump = 1

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)

" Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)


noremap fg  :GGrep<CR>
noremap fs  :Rg<CR>
noremap ff  :Files<CR>
noremap bb  :Buffers<CR>

" ===
" === Ultisnips
" ===
"" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<C-j>"
"let g:UltiSnipsJumpForwardTrigger="<C-j>"
"let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips/', 'UltiSnips']
silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>


" ===
" === Nerdcommenter
" ===
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1


" ===
" === Vista.vim
" ===
noremap <silent> T :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()


" ===
" === vim-bookmarks
" ===
let g:bookmark_no_default_key_mappings = 1
" 添加普通书签
nmap mt <Plug>BookmarkToggle
" 添加带描述的书签
nmap ma <Plug>BookmarkAnnotate
" 查看所有书签
nmap ml <Plug>BookmarkShowAll
" 跳转到下一个书签
nmap mi <Plug>BookmarkNext
" 跳转到上一个书签
nmap mn <Plug>BookmarkPrev
" 清除当前所有书签
nmap mC <Plug>BookmarkClear
" 清除所有书签
nmap mX <Plug>BookmarkClearAll
"nmap mu <Plug>BookmarkMoveUp
"nmap me <Plug>BookmarkMoveDown
"nmap <LEADER>g <Plug>BookmarkMoveToLine
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_manage_per_buffer = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_center = 1
let g:bookmark_auto_close = 1
let g:bookmark_location_list = 0
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '🔖'
let g:bookmark_highlight_lines = 1


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
let g:go_fmt_autosave                        = 1
let g:go_imports_autosave                    = 1
let g:go_mod_fmt_autosave                    = 1
let g:go_metalinter_autosave                 = 1
let g:go_metalinter_autosave_enabled         = ['vet', 'golint']
autocmd FileType go noremap gk :GoDoc<CR>
autocmd FileType go noremap gta :GoTest<CR>
autocmd FileTYpe go noremap gtt :GoTestFunc<CR>

" ===
" === Rust
" ===
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'


" ===
" === rnvimr
" ===
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
nnoremap <silent> R :RnvimrSync<CR>:RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 0.9, 'height': 0.9}]


" ===
" === vim-calendar
" ===
" E open Event list
" T open Task list
" D flag delete
" dd flag delete
" L delete is flag task
" U undo
" a\i\o add task or event
noremap \\ :Calendar -first_day=monday<CR>
noremap \cc :Calendar -view=clock<CR>
noremap \cy :Calendar -view=year<CR>


" ===================== End of Plugin Settings =====================

" ===
" === Create a _machine_specific.vim
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
