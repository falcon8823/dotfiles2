" This must be first, because it changes other options as a side effect.
set nocompatible
syntax on

filetype off


filetype plugin on
filetype indent on



" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hlsearch " do highlighting

"My Config

"日本語表示
set encoding=utf-8
set fileencodings=utf-8,shift-jis,euc-jp,latin1

" タブ幅, 自動インデント幅
set tabstop=2 shiftwidth=2 softtabstop=2
" タブをスペースに
set expandtab
set autoindent

" カラースキーム
colorscheme torte

" 行番号表示
set number

" 日本語の行連結時には空白を入力しない
set formatoptions+=mM

" 全角文字調整
set ambiwidth=double

" 最後の行をできる限り表示する
set display+=lastline

set nobackup

" unite.vim
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
au FileType unite nnoremap <silent> <buffer> <C-c> :q<CR>
au FileType unite inoremap <silent> <buffer> <C-c> <ESC>:q<CR>

" RubyスクリプトのSyntaxチェック
autocmd FileType ruby :map <C-s> <ESC>:!ruby -cW %<CR>
" Rubyスクリプトとしてを実行
autocmd FileType ruby :map <C-e> <ESC>:!ruby %<CR>

" 対の括弧の自動補完
"imap { {}<LEFT><LEFT><LEFT><LEFT><LEFT>
"imap [ []<++><LEFT><LEFT><LEFT><LEFT><LEFT>
"imap ( ()<++><LEFT><LEFT><LEFT><LEFT><LEFT>
"imap （ （）<++><LEFT><LEFT><LEFT><LEFT><LEFT>

" ファイルの雛形
augroup SkeletonAu
	autocmd!
	autocmd BufNewFile *.c 0r $HOME/.vim/skel.c
	autocmd BufNewFile *.cpp 0r $HOME/.vim/skel.cpp
	autocmd BufNewFile *.java 0r $HOME/.vim/skel.java
	autocmd BufNewFile Gemfile 0r $HOME/.vim/Gemfile.skel
augroup END

" java
autocmd FileType java set dictionary=j2se142.dict

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

let g:neocomplcache_force_overwrite_completefunc=1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"""" 終わり


" 検索ハイライトの消去
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" ターミナルでマウスを使用できるようにする
set mouse=a
"set guioptions+=a
"set ttymouse=xterm2

"クリップボードを共有する
"set clipboard=unnamed,autoselect

" 末尾の空白をハイライト
highlight WhitespaceEOL cterm=underline ctermbg=red guibg=#FF0000
au BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
au WinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')

augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" local固有の設定ファイルを読み込む
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
