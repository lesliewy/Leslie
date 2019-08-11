""" vim-markdown 插件
""" 这两句报不支持了，还没查原因.
""" au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=mkd
""" let g:vim_markdown_folding_disabled=1
""" vim-markdown 插件 END
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" 这个必须的;
set nocompatible

" allow backspacing over everything in insert mode
" 没有的话,在insert模式下,backspace不可以删除.
set backspace=indent,eol,start

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
" set backup		" keep a backup file,   自动产生一个 filename~ 文件.
"endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
"  set mouse=a
  set mouse=v   " 允许使用系统粘帖板
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

  " For all text files set 'textwidth' to 78 characters.  会自动换行
"  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.          上次打开文件时光标的位置.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" 设置编码,打开中文文件.
set encoding=utf-8
" 设置tap为3个空格, expandtab 使用空格.
set tabstop=3
set expandtab
" visual模式下，> < 整体移动时使用.
set shiftwidth=3

" map
" map 
"nmap \c I#<Esc>
"nmap <silent> <F4> :set opfunc=CountSpaces<CR>g@
" function! 重新定义该function
" 这个报不支持了，还没查原因  let 语法也不支持了.
"function! CountSpaces(type, ...)
"          let sel_save = &selection
"          let &selection = "inclusive"
"          let reg_save = @@
"
"          if a:0  " Invoked from Visual mode, use '< and '> marks.
"            silent exe "normal! `<" . a:type . "`>y"
"          elseif a:type == 'line'
"            silent exe "normal! '[V']y"
"          elseif a:type == 'block'
"            silent exe "normal! `[\<C-V>`]y"
"          else
"            silent exe "normal! `[v`]y"
"          endif
"
"          echomsg strlen(substitute(@@, '[^ ]', '', 'g'))
"
"          let &selection = sel_save
"          let @@ = reg_save
"        endfunction

" 折行不截断单词
set linebreak
" 相对行号
set relativenumber


" javacomplete plugin begin
setlocal omnifunc=javacomplete#Complete
"autocmd FileType java set omnifunc=javacomplete#Complete
"autocmd FileType java set completefunc=javacomplete#CompleteParamsInf
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
  inoremap <buffer> <C-S-Space> <C-X><C-U><C-P> 
"  autocmd Filetype java,javascript,jsp inoremap <buffer>  .  .<C-X><C-O><C-P>
" javacomplete plugin end

" javabrowser plugin begin
"let JavaBrowser_Ctags_Cmd = '/usr/bin/ctags'
"let Javabrowser_Use_Icon = 1
"let JavaBrowser_Use_Highlight_Tag = 1
map <F12> :JavaBrowser<CR> 
imap <F12> <ESC><F12>
" javabrowser plugin end

" nerdtree plugin begin
map <F2> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
" nerdtree plugin end

" Conque shell plugin begin
"let g:ConqueTerm_CWInsert = 1
":command -range=% CS :ConqueTermVSplit bash
" Conque shell plugin end

" jk 按虚拟行移动
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

