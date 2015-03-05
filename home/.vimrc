" see these bundles
" https://github.com/scrooloose/syntastic
" https://github.com/tpope/vim-sensible
" https://github.com/tpope/vim-dispatch

execute pathogen#infect()

let g:syntastic_javascript_checkers = ['gjslint', 'jshint', 'jscs']
let g:syntastic_aggregate_errors = 1
let g:vim_markdown_folding_disabled = 1

" syntastic recommended settings for newbies
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

function! MySettings ()
  " stop all magic formatting
  set formatoptions-=cro
  set noautoindent nocindent nosmartindent indentexpr=
  filetype indent off

  " stop all beeping
  set noerrorbells visualbell t_vb=
  autocmd GUIEnter * set visualbell t_vb=

  " cleaner web
  set sw=2 ts=2 sts=2 expandtab

  " FreeBSD Security Team advisory
  set nomodeline

  set list
  set ignorecase

  hi specialkey ctermfg=lightgrey
  hi type ctermfg=1
  hi statement ctermfg=1
  hi DiffAdd ctermbg=3
  hi Ignore ctermbg=1
endfunction


" VimEnter is a hook that should fire after plugins, so we can override
" otherwise .vimrc is run first and overriden by everything else
call MySettings()
autocmd VimEnter * call MySettings()


"map <S-F5> <ESC>q5
"map <F5> @5

" Atomz settings
"au BufNewFile,BufRead *.tkh	setf html
"let g:DirDiffExcludes = "CVS"
"map <F15> :w<CR>:make<CR>:cw<CR>

" scala
au BufRead,BufNewFile *.scala set filetype=scala
au! Syntax scala source ~/.vim/syntax/scala.vim
