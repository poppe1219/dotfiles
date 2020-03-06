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
hi CursorLine cterm=NONE ctermbg=235
hi SpecialKey cterm=NONE ctermfg=DarkBlue
hi NonText ctermfg=DarkBlue
hi OverLength ctermfg=NONE ctermbg=NONE
hi Visual ctermbg=238
set colorcolumn=80
hi ColorColumn ctermbg=235
hi LineNr cterm=NONE ctermfg=23 ctermbg=NONE
hi CursorLineNr cterm=NONE ctermfg=16 ctermbg=23
set report=0 "Show all changes."
set scrolloff=5
set sidescrolloff=7
set sidescroll=1

"Centralize backup files, avoids the pesky .swp file in repos."
set backupdir=~/.vim/backups
set directory=~/.vim/swaps

set listchars=trail:·,precedes:«,extends:»,tab:>·,eol:¬,nbsp:×
set list

set splitbelow
set splitright

" Enable mouse use in all modes
set mouse=a
" Set this to the name of your terminal that supports mouse codes.
"set ttymouse=urxvt

set history=999 "keep 999 lines of command line history
set backspace=indent,eol,start  " more powerful backspacing

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg


"set statusline=%f%m%r%=%y\ %{&enc}/%{&fenc}\ %03b(%2Bh)\ C:%3c\ L:%4l/%4L


" Set up the status line
fun! <SID>SetStatusLine()
    let l:s1="%-3.3n\\ %f\\ %h%m%r%w"
    let l:s2="[%{strlen(&filetype)?&filetype:'?'},%{&encoding},%{&fileformat}]"
    let l:s3="%=\\ 0x%-8B\\ \\ %-14.(%l,%c%V%)\\ %<%P"
    execute "set statusline=" . l:s1 . l:s2 . l:s3
endfun
set laststatus=2
call <SID>SetStatusLine()


" Set up the status line
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

" Formats the statusline
set statusline=%f                           " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag

"" Puts in the current git status
"    if count(g:pathogen_disabled, 'Fugitive') < 1   
"        set statusline+=%{fugitive#statusline()}
"    endif
"
"" Puts in syntastic warnings
"    if count(g:pathogen_disabled, 'Syntastic') < 1  
"        set statusline+=%#warningmsg#
"        set statusline+=%{SyntasticStatuslineFlag()}
"        set statusline+=%*
"    endif

set statusline+=\ %=                        " align left
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
set statusline+=\ Buf:%n                    " Buffer number
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor


au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=7

" default the statusline to green when entering Vim
hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=248

hi VertSplit ctermfg=238 ctermbg=248
hi StatusLineNC ctermfg=238 ctermbg=248

