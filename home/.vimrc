" see these bundles
" https://github.com/scrooloose/syntastic
" https://github.com/tpope/vim-sensible
" https://github.com/tpope/vim-dispatch

execute pathogen#infect()

let g:syntastic_javascript_checkers = ['gjslint', 'jshint', 'jscs']
let g:syntastic_aggregate_errors = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_json_syntax_conceal = 0

let g:syntastic_scala_scalastyle_jar = '/usr/local/Cellar/scalastyle/0.6.0/libexec/scalastyle_2.10-0.6.0-batch.jar'
let g:syntastic_scala_scalastyle_config_file = '/usr/local/etc/scalastyle_config.xml'
let g:scala_sort_across_groups=1
let g:scala_first_party_namespaces='\(common\|controllers\|views\|models\|domain\|util\)'

" syntastic recommended settings for newbies
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{SyntasticStatuslineFlag()}%y%=%-16(\ %l,%c\ %)%P

let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" jump to last position when reopening file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" cleaner web, placed here so plugins can override
set sw=2 ts=2 sts=2 expandtab

function! MySettings ()
  " stop all magic formatting
  set formatoptions-=cro
  set noautoindent nocindent nosmartindent indentexpr=
  filetype indent off

  " stop all beeping
  set noerrorbells visualbell t_vb=
  autocmd GUIEnter * set visualbell t_vb=


  " FreeBSD Security Team advisory
  set nomodeline

  set nolist
  set ignorecase smartcase  " case insensitive unless caps in search

"  hi specialkey ctermfg=lightgrey
"  hi type ctermfg=1
"  hi statement ctermfg=1
"  hi DiffAdd ctermbg=3
"  hi Ignore ctermbg=1
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

