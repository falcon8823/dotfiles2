" 行数
set lines=35

" 表示フォント
set guifont=Ricty\ Discord\ Regular:h15

" カラースキーム
colorscheme torte

" IMEの状態でカーソルの色を変更する
if has('multi_byte_ime')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endif

