" example for a vimrc file.
"
" Maintainer: Bram Moolenaar <Bram@vim.org>
" Last change: 2008 Jul 02
"
" To use it, copy it to
" for Unix and OS/2: ~/.vimrc
" for Amiga: s:.vimrc
" for MS-DOS and Win32: $VIM\_vimrc
" for OpenVMS: sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set shiftwidth=4
set tabstop=4

if has("vms")
  set nobackup " do not keep a backup file, use versions instead
else
  set backup " keep a backup file
endif
set history=50 " keep 50 lines of command line history
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set incsearch " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
\ | wincmd p | diffthis
endif

colorscheme molokai

let mapleader="ß"
let g:mapleader="ß"
" mapleader should not time out
" set notimeout

inoremap üü <Esc>
nnoremap öö :w<CR>

" toggle taglist
nnoremap <leader>tt :TlistToggle<CR>

" Move entire line/block up and down
nnoremap <C-S-DOWN> :m+<CR>==
nnoremap <C-S-UP> :m-2<CR>==
inoremap <C-S-DOWN> <Esc>:m+<CR>==gi
inoremap <C-S-UP> <Esc>:m-2<CR>==gi
vnoremap <C-S-DOWN> :m'>+<CR>gv=gv
vnoremap <C-S-UP> :m-2<CR>gv=gv

" Highlight on overlenght
if exists('+colorcolumn')
	set colorcolumn=79
	highlight link OverLength ColorColumn
	exec 'match OverLength /\%'.&cc.'v.\+/'
else
	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)
endif 

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" navigate between windows
nnoremap <leader><left> <C-W>h
nnoremap <leader><right> <C-W>l
nnoremap <leader><up> <C-W>k
nnoremap <leader><down> <C-W>j

" tag navigation
nnoremap <leader><CR> <C-]>
nnoremap <leader><insert> <C-T>

set guifont=Monospace\ 8,\ Lucida_Console:h8:cANSI
"set guifont=Monospace\ 10
"set guifont=Lucida_Console:h8:cANSI

" hide toolbar
set guioptions-=T

call pathogen#infect()
