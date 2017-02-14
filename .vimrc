set nu "Line numbers"
set ruler
set encoding=utf-8 "Always, aaalways utf-8, dammit!"
set nobomb "Skip the annoying Byte Order Mark."
syntax on
set nocompatible "Use vim defaults instead of vi-compatiility."
set lazyredraw "Don't redraw while executing macros."
set ttyfast "Improves smootheness when redrawing."
set fileformats=unix,dos,mac
set autoread "Reload files if changed externally."
set cmdheight=2
set title
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set cursorline "Highlight line with cursor."
hi CursorLine cterm=NONE ctermbg=Black
hi SpecialKey cterm=NONE ctermfg=DarkBlue
hi NonText ctermfg=DarkBlue
hi OverLength ctermfg=NONE ctermbg=NONE
set colorcolumn=80
hi ColorColumn ctermbg=Black
hi LineNr cterm=NONE ctermfg=Black ctermbg=NONE
hi CursorLineNr ctermfg=Gray ctermbg=Black
set report=0 "Show all changes."
set scrolloff=5
set sidescrolloff=7
set sidescroll=1

"Centralize backup files, avoids the pesky .swp file in repos."
set backupdir=~/.vim/backups
set directory=~/.vim/swaps

set listchars=space:·,trail:·,precedes:«,extends:»,tab:>·,eol:¬,nbsp:×
set list

set splitbelow
set splitright

" Enable mouse use in all modes
set mouse=a
" Set this to the name of your terminal that supports mouse codes.
set ttymouse=urxvt

set history=999 "keep 999 lines of command line history
set backspace=indent,eol,start  " more powerful backspacing

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

set statusline=%f%m%r%=%y\ %{&enc}/%{&fenc}\ %03b(%2Bh)\ C:%3c\ L:%4l/%4L

