" My .vimrc
" Author: Julian Loschelders
" chapter bar = comment+space+78 stars = 80 chars
" ******************************************************************************

set nocompatible

" ******************************************************************************
" (1) GENERAL OS SETTINGS
" ******************************************************************************
" check os
" windows
let s:isWin = has('win32') || has('win64')
" linux / unix
let s:isUnix = has('unix')
" mac
let s:isOSX = has('mac')

" check if terminal
let s:isTerminal = !has('gui_running')

" check binaries an other stuff
let s:mysettings = {}
let s:mysettings.hasPython = has('python') || has('python3')
let s:mysettings.hasCtags = 0
let s:mysettings.hasPandoc = 0
let s:mysettings.hasTmux = 0
let s:mysettings.hasDevelopment = 0

if s:isWin
    let  s:mysettings.hasDevelopment = 1
endif

if s:isOSX
    let s:mysettings.hasCtags = 1
    let s:mysettings.hasPandoc= 1
    let s:pandocMakeDefault=0
    let s:mysettings.hasTmux= 1
    let s:mysettings.hasDevelopment = 1
endif

if s:isUnix
    let s:mysettings.hasTmux= 1
endif

" Global file paths
" '/' at end will save these files with absolute path to ensure unique
" filesnames
if s:isWin
    set undodir=~/vimfiles/undo//
    set backupdir=~/vimfiles/backup//
    set directory=~/vimfiles/swp//
endif
if s:isUnix || s:isOSX
    set undodir=~/.vim/undo//
    set backupdir=~/.vim/backup//
    set directory=~/.vim/swp//
endif

" ******************************************************************************
" (2) PLUGINS (Plugin Manager Vundle)
" ******************************************************************************

if s:isWin
    let path='~/vimfiles/plugged'
endif
if s:isUnix || s:isOSX
    let path='~/.vim/plugged'
endif

call plug#begin(path)
" plugin better default settings for vim
" docs: https://github.com/tpope/vim-sensible
Plug 'tpope/vim-sensible'
" plugin using git in vim
" docs: https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
" plugin easy comment and uncomment
" docs: https://github.com/scrooloose/nerdcommenter
Plug 'scrooloose/nerdcommenter'
" plugin file systen tree view and buffer management
" docs: https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" plugin surround text with brackets () {} [], quotes '', etc
" repeat will also repeat (.) surround commands
" docs: https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" plugin vim colorsheme solarized
" docs: https://github.com/altercation/vim-colors-solarized
Plug 'altercation/vim-colors-solarized'
" plugin nice looking statusline
" docs: https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"plugin easy tab-completion
"docs: https://github.com/ervandew/supertab
Plug 'ervandew/supertab'
"plugin code highlighting robot framework
" docs: https://github.com/mfukar/robotframework-vim
Plug 'mfukar/robotframework-vim', { 'for': 'robot' }
" plugin snippet management and vim-snippets for predefined snippets
" docs: https://github.com/SirVer/ultisnips
"if s:mysettings.hasPython
"    Plug 'SirVer/ultisnips'
"    Plug 'honza/vim-snippets'
"endif
" plugin more text regions brackets () {} [], quotes ''
" docs: https://github.com/wellle/targets.vim
Plug 'wellle/targets.vim'
" plugin fuzzy finder
" docs: https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'
" plugin for easy tag management
" docs: https://github.com/xolox/vim-easytags
if s:mysettings.hasCtags
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-easytags'
endif
" plugin visually show indent and indent text object
" docs: https://github.com/nathanaelkane/vim-indent-guides
" docs: https://github.com/michaeljsmith/vim-indent-object
Plug 'nathanaelkane/vim-indent-guides'
Plug 'michaeljsmith/vim-indent-object'
" plugin new startscreen show last used files, etc.
" docs https://github.com/mhinz/vim-startify
Plug 'mhinz/vim-startify'
" plugin run shell command in tmux pane
" docs https://github.com/benmills/vimux
if s:mysettings.hasTmux
    " plugin switching between tmux and vim splits
    " docs: https://github.com/christoomey/vim-tmux-navigator
    Plug 'christoomey/vim-tmux-navigator'
endif
if s:isOSX
"plugin nice looking icons
" docs: https://github.com/ryanoasis/vim-devicons
Plug 'ryanoasis/vim-devicons'
endif
" plugin for typescript highlighting
" docs: https://github.com/leafgarland/typescript-vim
Plug 'leafgarland/typescript-vim', { 'for': 'ts' }
" plugin for vue js highlighting (mixed content js, html, css)
" docs: https://github.com/posva/vim-vue
Plug 'posva/vim-vue', { 'for': 'vue' }
if s:mysettings.hasDevelopment
    " plugin for formatter, linter, etc.
    " docs: https://github.com/dense-analysis/ale
    Plug 'dense-analysis/ale'
endif
" plugin for interactively use jq on json buffer
" https://github.com/bfrg/vim-jqplay
Plug 'bfrg/vim-jqplay', { 'for': 'json' } 
call plug#end()
" use filetype plugins
filetype plugin indent on

" ******************************************************************************
" (3) EDITOR CONFIGURATION
" ******************************************************************************

" set space between lines
set linespace=3
" smart autoindenting when starting a new line
set smartindent

" default indentation
" number of spaces to use for each step of (auto)indent
set shiftwidth=4
" number of spaces that a <Tab> in the file counts for
set softtabstop=4
set tabstop=4

" filetype specific indentation
autocmd FileType robot setlocal shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 tabstop=2

" use the appropriate number of spaces to insert <Tab>
set expandtab
" When on, a <Tab> in front of a line inserts blanks according to
" 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places.
set smarttab
" show line numbers
set number
" show relative line numbers
set relativenumber

" use standard utf-8 encoding
set encoding=UTF-8
" use standard unix file formatting even for windows
set fileformat=unix

" While typing a search command, show where the pattern, as it was typed
" so far, matches. The matched string is highlighted.
set incsearch
" Ignore case in search patterns.  Also used when searching in the tags
" file.
set ignorecase
" When 'wildmenu' is on, command-line completion operates in an enhanced
" mode.  On pressing 'wildchar' (usually <Tab>) to invoke completion,
" the possible matches are shown just above the command line, with the
" first match highlighted (overwriting the status line, if there is
"one).
set wildmenu
" If in Insert, Replace or Visual mode put a message on the last line.
set showmode

" backup ,swap an undofiles
" no backup or swapfiles
set nobackup
set noswapfile
" but persistent undofiles
set undofile

" use system clipboard for default yank
set clipboard=unnamed

" When off a buffer is unloaded when it is abandoned.  When on a
" buffer becomes hidden when it is w abandoned.
" change between buffers without saving
set hidden

" ';' search recursive backwords for tags File
set tags=tags;

" ******************************************************************************
" (4) VISUAL CONFIGURATION
" ******************************************************************************

" show syntax highlighting
syntax enable

" color scheme solarized
if s:isWin || s:isTerminal
    set background=dark
else
    set background=light
endif

" color fix for terminal
" use this fix before(!) choosing colorsheme
if s:isTerminal
    let g:solarized_termcolors=256
    set t_Co=256
    set t_ut=
endif

colorscheme solarized

" status line configuration slightly similar to airline
" show statusline always (2)
set laststatus=2
set statusline=
" use 1 space between statusline groups
let statusSpace= ' '
" status flags:
" h = Help buffer flag, text is '[help]'.
" m = Modified flag, text is '[+]'; '[-]' if 'modifiable' is off.
" r = Readonly flag, text is '[RO]'.
" w = Preview window flag, text is '[Preview]'.
set statusline+=%h%m%r%w
" Path to the file in the buffer, as typed or relative to current directory
set statusline+=%f%{statusSpace}
" Separation point between left and right aligned items.
" No width fields allowed.
set statusline+=%=
" show file encoding
set statusline+=%{&enc}
" show file format
set statusline+=[%{&ff}]%{statusSpace}
" filetype
" y = Type of file in the buffer, e.g., '[vim]'.  See 'filetype'.
set statusline+=%y%{statusSpace}
" show current time
set statusline+=%{strftime(\'%H:%M\')}

" Use visual bell instead of beeping.
set visualbell

" gui options
if has("gui_running")
    " 'm' Menu bar is present.
    set guioptions-=m
    if s:isOSX
        " guifont and size
        set guifont=Hack\ Regular\ Nerd\ Font\ Complete:h22

    endif
    if s:isWin
        " 'T' Include Toolbar.
        set guioptions-=T
        " guifont and size
        set guifont=Consolas:h20
    endif
endif

" ******************************************************************************
" (5) CUSTOM PLUGIN CONFIGURATION
" ******************************************************************************

" VIM-AIRLINE PLUGIN
" ------------------
" enable airline plugin
let g:airline#extensions#tabline#enabled = 1
" overwrite default airline configuration in function airline#init#sections() file init.vim
" https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/init.vim
" show current time instead of text position
let g:airline_section_z = airline#section#create(["%{strftime(\'%H:%M\')}"])

" VIM-SURROUND PLUGIN
" -------------------
" custom robot framework surroundings
" change surrounding for $ (ascii code 36) to ${}
autocmd FileType robot let b:surround_36 = "${\r}"

" NERDCOMMENTER PLUGIN
" --------------------
" override the default delimiters for robot files.
let g:NERDCustomDelimiters = {
        \ 'robot': { 'left': '#'}
    \ }
" comment out whole lines if there is no multipart delimiters
" but the EXACT text that was selected if there IS multipart delimiters
" multipart delimiters e.g. in java /* this is a comment */
let NERDCommentWholeLinesInVMode=2
" comment whole lines at beginning of line regardless of current indentation
" level
let NERDDefaultAlign='start'
let NERDRemoveExtraSpaces=0

" CTRLP PLUGIN
" ------------
"
" tag = Search for a tag within a generated central tags file, and jump to the definition
" buffertag = Search for a tag within the current buffer or all listed buffers and jump to the definition
" quickfix = Search for an entry in the current quickfix errors and jump to it.
" dir = Search for a directory and change the working directory to it.
" rtscript = Search for files (vimscripts, docs, snippets...) in runtimepath.
" undo = Browse undo history.
" line = Search for a line in all listed buffers or in the specified [buffer].
" changes = Search for and jump to a recent change in the current buffer or in all listed buffers.
" mixed = Search in files, buffers and MRU files at the same time.
" bookmarkdir = Search for a bookmarked directory and change the working directory to it.

" enable extensions
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|DS_Store)|venv|node_modules$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" EASYTAGS PLUGIN
" ---------------
" update project tags files instead of .vimtags
let g:easytags_dynamic_files = 1

if s:isOSX
    " DEVICONS PLUGIN
    " ---------------
    let g:WebDevIconsOS = 'Darwin'

    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['robot'] = 'ﮧ'
endif

" ALE Asynchronous Lint Engine PLUGIN
" -----------------------------------

if s:mysettings.hasDevelopment
    let g:ale_completion_enabled = 1
    let g:ale_fix_on_save = 1
    set omnifunc=ale#completion#OmniFunc
    let g:ale_linters = {
        \ 'python': ['pyls', 'flake8'],
        \ 'typescript': ['tsserver'],
        \ 'javascript': ['tsserver'],
        \ 'vue': ['vls']
        \ }
    let b:ale_fixers = {
        \ 'python': ['black','pyls'],
        \ 'typescript': ['eslint','prettier'],
        \ 'javascript': ['eslint','prettier']
        \ }
    let g:ale_completion_tsserver_autoimport = 1
endif

" qplay - plugin
" --------------
if s:isWin
    let g:jqplay_jq_exe_path = 'C:\Users\Julian\jq\jq-win64.exe'
endif
if s:isUnix || s:isOSX
    let g:jqplay_jq_exe_path = '/usr/local/bin/jq'
endif

let g:jqplay = {
    \ 'exe': g:jqplay_jq_exe_path,
    \ 'opts': '--tab',
    \ 'autocmds': ['TextChanged', 'CursorHoldI', 'InsertLeave']
    \ }

" ******************************************************************************
" (6) FILETYPE SPECIFIC CONFIGURATIONS
" ******************************************************************************

"Keyword definitions (iskeyword)
"autocmd FileType robot set iskeyword+=$,{,}

" set standard makeprg

if s:mysettings.hasPandoc
    " pandoc word output for markdown-files
    autocmd FileType mkd.markdown set makeprg=pandoc\ -f\ markdown\ -t\ docx\ -o\ %.docx\ %
    autocmd FileType markdown set makeprg=pandoc\ -f\ markdown\ -t\ docx\ -o\ %.docx\ %
endif

" start robot automation with os configuration
if s:isOSX
    autocmd FileType robot set makeprg=pybot\ -V\ ~/RobotChromeDriverOptions/variables.yaml\ %
endif
if s:isWin
    autocmd FileType robot set makeprg=python\ -m\ robot.run\ %
endif

" ******************************************************************************
" (7) KEY MAPPING CONFIGURATIONS
" ******************************************************************************

" use space as mapleader
let mapleader = "\<Space>"

" map "jk" to <ESC> in Insert-Mode  
inoremap jk <ESC>

" custom mappings with mapleader
" write file
nnoremap <Leader>w :w<CR>
" make file don't open terminal window
nnoremap <Leader>m :silent make<CR>
" close buffer
nnoremap <Leader>b :bd<CR>
" force next buffer
nnoremap <Leader><Tab> :bn!<CR>
" show ctrlp-file mode
nnoremap <Leader>p :CtrlP<CR>
" show ctrlp-buffer mode
nnoremap <Leader>o :CtrlPBuffer<CR>
" show ctrlp-tag mode
nnoremap <Leader>t :CtrlPTag<CR>
" reload .vimrc
if s:isOSX
    nnoremap <Leader>r :source ~/.vimrc<CR>
endif
if s:isWin
    nnoremap <Leader>r :source ~/_vimrc<CR>
endif
" insert filename
nnoremap <Leader>fn "=expand("%:t")<CR>p
" Toggle NerdTree in Current Folder
nnoremap <Leader>n :NERDTreeToggle %<CR>
" change current dir to active File
nnoremap <Leader>cd :cd %:p:h<CR>
" yank current filename and line
nnoremap <leader>y :let @+=expand("%") . ':' . line(".")<CR>

" jump to tag by pressing 't'
nnoremap t <C-]>

" custom vimgrep command
nnoremap <leader>g :set operatorfunc=VimGrepFiles<cr>g@
vnoremap <leader>g :<c-u>call VimGrepFiles(visualmode())<cr>

" ******************************************************************************
" CUSTOM VIM FUNCTIONS
" ******************************************************************************
" use ! after function statement to overwrite existing functions
" and supress warning at .vimrc reload

" toggle make program on markdown file types
if s:mysettings.hasPandoc
    function! PandocMakePrgToggle(...)
        if s:pandocMakeDefault
            echom "set pandoc makeprg docx"
            set makeprg=pandoc\ -f\ markdown\ -t\ docx\ -o\ %.docx\ %
            let s:pandocMakeDefault = 0
        else
            let reveal_theme=get(a:, 1, "solarized")
            echom "set pandoc makeprg reveal theme: " . reveal_theme
            let &makeprg = "pandoc -f markdown -t revealjs -s -V theme=" . reveal_theme . " -o %.html %"
            let s:pandocMakeDefault = 1
        endif
    endfunction
endif

" vimgrep movement in files with same filetype
function! VimGrepFiles(type)
    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    execute "vimgrep " . shellescape(@@) . " **/*." . expand('%:e')
    copen
endfunction

" ******************************************************************************
" GENERATE HELP TAGS FOR ALL PLUGINS
" ******************************************************************************
" Put these lines at the very end of your vimrc file.

" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
