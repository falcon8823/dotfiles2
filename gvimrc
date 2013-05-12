" 行数
set lines=35

" カラースキーム
colorscheme torte

" IMEの状態でカーソルの色を変更する
if has('multi_byte_ime')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endif

" local固有の設定ファイルを読み込む
if filereadable(expand('~/.gvimrc.local'))
  source ~/.gvimrc.local
endif
