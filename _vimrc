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

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

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

"colorscheme molokai

let mapleader="ß"
let g:mapleader="ß"
let maplocalleader = "ß"
" mapleader should not time out
" set notimeout

inoremap üü <Esc>
nnoremap ö :w<CR>

" toggle taglist
nnoremap <leader>tt :TlistToggle<CR>
let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
let Tlist_Close_On_Select = 1 " Close the taglist window when a file or tag is selected.
"taglist automatic folding of unvisible files
let Tlist_File_Fold_Auto_Close=1
" display prototypes intstead of tags (used only because of ctags bug with
" pjsip
let Tlist_Display_Prototype=1
let Tlist_WinWidth = 60

" Move entire line/block up and down
"nnoremap <C-S-DOWN> :m+<CR>==
"nnoremap <C-S-UP> :m-2<CR>==
"inoremap <C-S-DOWN> <Esc>:m+<CR>==gi
"inoremap <C-S-UP> <Esc>:m-2<CR>==gi
"vnoremap <C-S-DOWN> :m'>+<CR>gv=gv
"vnoremap <C-S-UP> :m-2<CR>gv=gv

" Highlight on overlenght
if exists('+colorcolumn')
	set colorcolumn=81
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
nnoremap <leader><home> 0<C-W>w

" tag navigation
	"jump to tag
nnoremap <leader><CR> <C-]>
	" jump to tag in new vertical split
	" show tag in preview window
nnoremap <leader>~ <C-W>}
	" close preview window
nnoremap <leader><Bar> <C-W>z
	"back to last jump position
"nmap <leader><insert> <C-T>
nnoremap <leader><insert> <C-T>
" programming
"nnoremap cn :cn<return>
"nnoremap cp :cp<return>
" ignore warnings in quickfix window !!use with care!!
"set errorformat^=%-G%f:%l:\ warning:%m
" ignore notes in quickfix window !!use with care!!
"set errorformat^=%-G%f:%l:\ note:%m

" fold navigation
nmap z<up> zk
nmap z<down> zj

set guifont=Monospace\ 8,\ Lucida_Console:h8:cANSI
"set guifont=Monospace\ 10
"set guifont=Lucida_Console:h8:cANSI

" hide toolbar
set guioptions-=T

" force 256 color support
" set t_Co=256
set t_Co=16

" disable autotag, set to 0 or delete to activate autotag
"let g:autotag_vim_version_sourced=1

" powerline
set laststatus=2
set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim

" fugitive
set diffopt=filler,vertical
nnoremap <leader>gs :Gstatus<CR>

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = ['OmniCppComplete','clang_complete','supertab']

call pathogen#infect()
Helptags

syntax enable
set background=dark
colorscheme solarized

" quit ConqueTerm when program running in ConqueTerm quits
let g:ConqueTerm_CloseOnEnd = 1

" clang complete
let g:clang_snippets=1
let g:clang_snippets_engine = 'clang_complete'
"let g:clang_snippets_engine = 'ultisnips'
let g:clang_close_preview=1
" to debug clang complete
"let g:clang_debug=1
"let g:clang_complete_auto = 1
"let g:clang_complete_copen = 1

" LaTeX-Box
let g:LatexBox_output_type = "pdf"
let g:LatexBox_quickfix = 2 " do not jump to quickfix window
let g:LatexBox_Folding = 1

" set language to english independent of system language
let g:fugitive_git_executable = 'LANG=en_US git'

" syntastic
" make syntastic C++11 aware
let g:syntastic_cpp_compiler_options = ' -std=c++11'
" use location list (jump to errors with :lne and :lp)
let g:syntastic_always_populate_loc_list=1

" YouCompleteMe
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
" do not use TAB, this should be kept for UltiSnips
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
