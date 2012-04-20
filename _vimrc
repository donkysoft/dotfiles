set nocompatible			" Vi互換をオフ
filetype off

if has("win32") || has("win64")
  set rtp+=~/vimfiles/vundle.git/ 
  call vundle#rc('~/vimfiles/bundle/')
else
  set rtp+=~/.vim/vundle.git/ 
  call vundle#rc()
endif

Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
Bundle 'mattn/zencoding-vim'

filetype plugin indent on	" pluginをonにする



"set cindent				" C言語用のインデントを有効にする
syntax on					" シンタックスonにする
set backup
set backupdir=~/vimbackup	" バックアップファイル用ディレクトリ
let &directory = &backupdir	" swapファイル用ディレクトリ
set browsedir=buffer 		" ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定

set hidden					" 変更中のファイルでも、保存しないで他のファイルを表示
set incsearch				" インクリメンタルサーチを行う
"set list					" タブ文字、行末など不可視文字を表示する
set number					" 行番号を表示する
set shiftwidth=4			" シフト移動幅（オートインデント時に使用するインデントの深さ）
set smartindent				" 新しい行を作ったときに高度な自動インデントを行う
set smarttab				" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set tabstop=4				" ファイル内の <Tab> が対応する空白の数
"set whichwrap=b,s,h,l,<,>,[,]	" カーソルを行頭、行末で止まらないようにする（これ、なんだべ？）
set scrolloff=5				" スクロール上下猶予行数
set backspace=2				" バックスペース
set wildmode=longest,list,full	" wildmode


""""" Ctrl+p でそのまま実行
function! s:Exec()
    exe "!" . &ft . " %"
:endfunction
command! Exec call <SID>Exec()
map <silent> <C-P> :call <SID>Exec()<CR>

""""" バッファを閉じる時にウインドウ分割を保持する
:com! Kwbd let kwbd_bn= bufnr("%")|enew|exe "bdel ".kwbd_bn|unlet kwbd_bn 

""""" バッファ移動
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:Kwbd<CR>


""""" 表示行単位で行移動するようにする
nnoremap j gj
nnoremap k gk


""""" Escの2回押しで検索ハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>


""""" neocomplcache.vim関連
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化


""""" unite.vim関連
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-B> :Unite buffer<CR>
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
" 初期設定関数を起動する
au FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Overwrite settings.
endfunction
" 様々なショートカット
call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)
call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/"', 2)
call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/"')
call unite#set_substitute_pattern('file', '^\~', escape($HOME, '\'), -2)
call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)
if has('win32') || has('win64')
  call unite#set_substitute_pattern('file', '^;p', 'C:/Program Files/')
  call unite#set_substitute_pattern('file', '^;v', '~/vimfiles/')
else
  call unite#set_substitute_pattern('file', '^;v', '~/.vim/')
endif


""""" buftabs
" バッファタブにパスを省略してファイル名のみ表示する
let g:buftabs_only_basename=1
" バッファタブをステータスライン内に表示する
let g:buftabs_in_statusline=1
" 現在のバッファをハイライト
let g:buftabs_active_highlight_group="Visual"
" ステータスライン
set statusline=%=\ [%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\[%04l,%04v][%p%%]
" ステータスラインを常に表示
set laststatus=2
