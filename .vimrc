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

" check binaries an other stuff
let s:mysettings = {}
let s:mysettings.hasPython = has('python') || has('python3')
let s:mysettings.hasCtags = 0
let s:mysettings.hasPandoc= 0

if s:isOSX
    let s:mysettings.hasCtags = 1
    let s:mysettings.hasPandoc= 1
endif

" ******************************************************************************
" (2) PLUGINS (Plugin Manager Vundle)
" ******************************************************************************
if s:isWin
    set rtp+=~/vimfiles/bundle/Vundle.vim/
    " path in which vundle should install plugins
    let path='~/vimfiles/bundle'
endif
if s:isUnix || s:isOSX
    set rtp+=~/.vim/bundle/Vundle.vim/
    let path='~/.vim/bundle'
endif
call vundle#begin(path)
" let Vundle manage Vundle, required
" docs: http://github.com/VundleVim/Vundle.Vim
Plugin 'gmarik/Vundle.vim'
" plugin using git in vim
" docs: https://github.com/tpope/vim-fugitive
Plugin 'tpope/vim-fugitive'
" plugin easy comment and uncomment
" docs: https://github.com/scrooloose/nerdcommenter
Plugin 'scrooloose/nerdcommenter'
" plugin file systen tree view and buffer management
" docs: https://github.com/scrooloose/nerdtree
Plugin 'scrooloose/nerdtree'
" plugin surround text with brackets () {} [], quotes '', etc
" repeat will also repeat (.) surround commands
" docs: https://github.com/tpope/vim-surround
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
" plugin vim colorsheme solarized
" docs: https://github.com/altercation/vim-colors-solarized
Plugin 'altercation/vim-colors-solarized'
" plugin nice looking statusline
" docs: https://github.com/vim-airline/vim-airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"plugin easy tab-completion
"docs: https://github.com/ervandew/supertab
Plugin 'ervandew/supertab'
"plugin code highlighting robot framework
" docs: https://github.com/mfukar/robotframework-vim
Plugin 'mfukar/robotframework-vim'
" plugin snippet management and vim-snippets for predefined snippets
" docs: https://github.com/SirVer/ultisnips
if s:mysettings.hasPython
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'
endif
" plugin more text regions brackets () {} [], quotes ''
" docs: https://github.com/wellle/targets.vim
Plugin 'wellle/targets.vim'
" plugin fuzzy finder
" docs: https://github.com/kien/ctrlp.vim
Plugin 'kien/ctrlp.vim'
" plugin for easy tag management
" docs: https://github.com/xolox/vim-easytags
if s:mysettings.hasCtags
    Plugin 'xolox/vim-misc'
    Plugin 'xolox/vim-easytags'
endif
" plugin visually show indent and indent text object
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'michaeljsmith/vim-indent-object'
call vundle#end()
" use filetype plugins
filetype plugin indent on

" ******************************************************************************
" (3) EDITOR CONFIGURATION
" ******************************************************************************

" smart autoindenting when starting a new line
set smartindent
" number of spaces to use for each step of (auto)indent
set shiftwidth=4
" number of spaces that a <Tab> in the file counts for
set tabstop=4
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
set encoding=utf-8
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

" backup and swapfiles
" no backup or swapfiles at all
set nobackup
set noswapfile

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
if s:isWin
    set background=dark
else
    set background=light
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
        set guifont=Monaco:h20
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

" EASYTAGS PLUGIN
" ---------------
" update project tags files instead of .vimtags
let g:easytags_dynamic_files = 1


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
" show ctrlp-tag mode
nnoremap <Leader>t :CtrlPTag<CR>
" reload .vimrc
nnoremap <Leader>r :source ~/.vimrc<CR>
" insert filename
nnoremap <Leader>fn "=expand("%:t")<CR>p

" jump to tag by pressing 't'
nnoremap t <C-]>

" ******************************************************************************
" CUSTOM VIM FUNCTIONS
" ******************************************************************************
" use ! after function statement to overwrite existing functions
" and supress warning at .vimrc reload

function! Note()
    cd ~/Documents/hugo/personal-notes/content/
    Explore
endfunction
" custom function mapping
nnoremap <Leader>n :call Note()<CR>