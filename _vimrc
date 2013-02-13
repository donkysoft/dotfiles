set nocompatible
filetype off


" NeoBundle
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim

  call neobundle#rc(expand('~/.vim/bundle/'))
endif

let OSTYPE = system("uname")

NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
" install :NeoBundleInstall
" install & update :NeoBundleInstall!
" clean :NeoBundleClean


" vimproc
NeoBundle 'Shougo/vimproc', {
\ 'build': {
\ 'windows': 'make -f make_mingw32.mak',
\ 'cygwin': 'make -f make_cygwin.mak',
\ 'mac': 'make -f make_mac.mak',
\ 'unix': 'make -f make_unix.mak',
\ }
\}


" neocomplcache
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
" neocomplcacheを有効にする
let g:neocomplcache_enable_at_startup = 1

"" 辞書補完
"let g:neocomplcache_dictionary_filetype_lists = {
"   \ 'default' : '',
"   \ 'javascript' : $HOME.'/dotfiles/vimfiles/jsjq.dict',
"   \ 'coffee' : $HOME.'/dotfiles/vimfiles/jsjq.dict',
"   \ 'html' : $HOME.'/dotfiles/vimfiles/jsjq.dict',
"   \ 'css' : $HOME.'/dotfiles/vimfiles/css.dict',
"   \ 'less' : $HOME.'/dotfiles/vimfiles/css.dict',
"   \ 'sass' : $HOME.'/dotfiles/vimfiles/css.dict',
"   \ }
" neocomplcacheのオムニ補完
autocmd FileType css,less,sass setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript,coffee setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" neocomplcache
" ネオコンのスニペット展開
NeoBundle 'git://github.com/Shougo/neosnippet.git'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" snippet の保管場所
let g:neosnippet#snippets_directory='~/dotfiles/vimfiles'


" vimshell
NeoBundle 'https://github.com/Shougo/vimshell.git'
let g:vimshell_interactive_update_time = 10
nnoremap <silent> ,vs :VimShell<CR>
nnoremap <silent> ,vsc :VimShellCreate<CR>
nnoremap <silent> ,vp :VimShellPop<CR>


"" ()[]{}""''などを挿入したら自動的に中へ
"NeoBundle 'git://github.com/kana/vim-smartinput.git'
"inoremap << <><LEFT>
"inoremap {% {%<Space><Space>%}<LEFT><LEFT><LEFT>

" template
autocmd BufNewFile *.py 0r $HOME/dotfiles/vimfiles/templates.py


" coffeescript
NeoBundle 'git://github.com/kchmck/vim-coffee-script.git'
autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!


" JScomplete
NeoBundle 'git://github.com/teramako/jscomplete-vim.git'


" NOTE:この順番で記述しないと補完と自動展開ができない
" lessの自動変換
NeoBundle 'git://github.com/plasticscafe/vim-less-autocompile.git'
autocmd BufRead,BufNewFile *.less set filetype=less
" 自動で変換
let g:less_autocompile=1
" 圧縮しない
let g:less_compress=0


" less補完
NeoBundle 'git://github.com/groenewege/vim-less.git'
autocmd BufNewFile,BufRead *.less set filetype=css


" 英語補完
NeoBundle 'https://github.com/ujihisa/neco-look.git'


" ctags で生成した各種宣言を表示 :Tlist
" taglist Macの /usr/bin/ctags は消すこと
NeoBundle 'taglist.vim'
set tags=.tags;


" HTMLやXMLなどの賢い展開
NeoBundle 'git://github.com/mattn/zencoding-vim.git'
let g:user_zen_expandabbr_key = '<c-e>'


" NERDCommenter トグルでコメント/コメントアウト
NeoBundle 'git://github.com/scrooloose/nerdcommenter.git'
nmap ,c <Plug>NERDCommenterToggle
vmap ,c <Plug>NERDCommenterToggle


" Kwbd
NeoBundle 'git://github.com/rgarver/Kwbd.vim.git'


" =================================================
" Syntax
" =================================================
" haml Sassのインデント、色付け
NeoBundle 'git://github.com/tpope/vim-haml.git'

" jade
NeoBundle 'jade.vim'

" Markdown
NeoBundle 'git://github.com/tpope/vim-markdown.git'

" Python
NeoBundle 'mitechie/pyflakes-pathogen'

" nginxのsyntax
NeoBundle 'nginx.vim'
au BufRead,BufNewFile /etc/nginx/* set ft=nginx

" JSON
NeoBundle 'JSON.vim'
au! BufRead,BufNewFile *.json set filetype=json

" blockdiag
NeoBundle 'git://github.com/aohta/blockdiag.vim.git'

" 各種構文チェックしてくれるらしい
NeoBundle 'git://github.com/scrooloose/syntastic.git'

" python は pyflakes
" javascript は jshint
" html は HTML Tidy
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['php', 'python', 'javascript', 'html'],
                           \ 'passive_filetypes': [] }
" =================================================
" Filer、参照
" =================================================

" VimFiler
NeoBundle 'git://github.com/Shougo/vimfiler.git'
" vimfilerをデフォルトにしない
let g:vimfiler_as_default_explorer = 0
let g:vimfiler_safe_mode_by_default = 0
" ,eでVimFilerの起動
nnoremap <silent>,e :<C-u>VimFilerBufferDir<CR>


" unite.vim
NeoBundle 'git://github.com/Shougo/unite.vim.git'
" 隠しファイル(.で始まるファイル)を表示するには /hoge/. と直接入力が必要
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-U><C-B> :Unite buffer<CR>
" ファイル一覧
"noremap <C-U><C-N> :Unite -buffer-name=file file<CR>
noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
" 最近使ったファイルの一覧
noremap <C-U><C-R> :Unite file_mru<CR>
" レジスタ一覧
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
" ファイルとバッファ
noremap <C-U><C-U> :Unite buffer file_mru<CR>
" 全部
noremap <C-U><C-A> :Unite UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
"" ウィンドウを分割して開く
"au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
"au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
"" ウィンドウを縦に分割して開く
"au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
"au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


" minibufexpl
NeoBundle 'fholgado/minibufexpl.vim'


" Ack.vim
" Macの場合 brew install ack
" Ubuntuの場合 sudo apt-get install ack-grep
" :Ack patterns
NeoBundle 'https://github.com/mileszs/ack.vim'
" for Debian/Ubuntu
if OSTYPE == "Linux\n"
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif
" =================================================
" その他
" =================================================
" 異なるvim間でのyank共有
NeoBundle 'yanktmp.vim'
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

" vi sudo:/etc/nginx/nginx.conf などと使う
" 現在開いているファイルをsudoで開くには :e sudo:%
NeoBundle 'sudo.vim'

" \r で現在開いているスクリプトを実行
NeoBundle 'git://github.com/thinca/vim-quickrun.git'

" =================================================
" colorschemeとか見た目とか
" =================================================
" unite-colorscheme
NeoBundle 'https://github.com/ujihisa/unite-colorscheme'
" molokai
NeoBundle 'molokai'
" desert
NeoBundle 'desert.vim'
" desert256
NeoBundle 'desert256.vim'
" ir_black
NeoBundle 'git://github.com/wgibbs/vim-irblack.git'

" ステータスラインをちょろっとする
NeoBundle 'git://github.com/Lokaltog/vim-powerline.git'
" ステータスラインを常に表示
set laststatus=2

" =================================================
" 通常設定
" =================================================
syntax on
filetype plugin indent on	" pluginをonにする
" 256色モード
set t_Co=256
" 256色カラーは各種ターミナルとVimとtmuxやscreenが対応している必要がある
colorscheme molokai

" 新しい行のインデントを現在行と同じにする
" set autoindent
" ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer
" クリップボードをWindowsと連携
set clipboard=unnamed
" Vi互換をオフ
set nocompatible
" スワップファイルをつくらない
set noswapfile
set nobackup
" タブの代わりに空白文字を挿入する
"set expandtab
" 変更中のファイルでも、保存しないで他のファイルを表示
set hidden
" インクリメンタルサーチを行う
set incsearch
" タブ文字、行末など不可視文字を表示する
set list
" listで表示される文字のフォーマットを指定する
set listchars=eol:¬,tab:▸\ ,extends:»
" 行番号を表示する
set number
" 閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
" 検索時に大文字を含んでいたら大/小を区別
set smartcase
" 新しい行を作ったときに高度な自動インデントを行う
set smartindent
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
" カーソルを行頭、行末で止まらないようにする
"set whichwrap=b,s,h,l,<,>,[,]
" 検索をファイルの先頭へループしない
"set nowrapscan
" 検索のハイライト
set hlsearch

" ハイライトをEscで抜ける
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 保存時に行末の空白を除去する
"autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
"autocmd BufWritePre * :%s/\t/  /ge

" Tabでウィンドウの移動
nnoremap <silent><Tab> <C-w>w

" >や<で幅調節
nnoremap <silent>> <C-w>>
nnoremap <silent>< <C-w><
"
" tn で新しいタブを開く。移動はgt
nnoremap <silent>tn :<C-u>:tabnew<CR>

" FileType
" シフト移動幅
" ファイル内の <Tab> が対応する空白の数
autocmd FileType * setlocal tabstop=4 shiftwidth=4
autocmd FileType javascript setlocal tabstop=4 shiftwidth=4
"autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd FileType coffee setlocal tabstop=4 shiftwidth=4
autocmd FileType sass setlocal tabstop=4 shiftwidth=4
autocmd FileType yaml setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType php setlocal tabstop=4 shiftwidth=4
""""" python
autocmd FileType python setlocal autoindent
autocmd FileType python setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4

" html、gfでのファイル移動
autocmd FileType html setlocal tabstop=2 shiftwidth=2
autocmd FileType tpl setlocal tabstop=2 shiftwidth=2
autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/',',') | setlocal path+=;/''

" スクロール上下猶予行数
set scrolloff=5
" バックスペース
set backspace=2
" バッファ移動
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:Kwbd<CR>
" 表示行単位で行移動するようにする
nnoremap j gj
nnoremap k gk

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












"""""" Ctrl+p でそのまま実行
"function! s:Exec()
"    exe "!" . &ft . " %"
":endfunction
"command! Exec call <SID>Exec()
"map <silent> <C-P> :call <SID>Exec()<CR>

"""""" バッファを閉じる時にウインドウ分割を保持する
":com! Kwbd let kwbd_bn= bufnr("%")|enew|exe "bdel ".kwbd_bn|unlet kwbd_bn



"""""" unite.vim関連
"" 初期設定関数を起動する
"au FileType unite call s:unite_my_settings()
"function! s:unite_my_settings()
"  " Overwrite settings.
"endfunction
"" 様々なショートカット
"call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)
"call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/"', 2)
"call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
"call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/"')
"call unite#set_substitute_pattern('file', '^\~', escape($HOME, '\'), -2)
"call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
"call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)
"if has('win32') || has('win64')
"  call unite#set_substitute_pattern('file', '^;p', 'C:/Program Files/')
"  call unite#set_substitute_pattern('file', '^;v', '~/vimfiles/')
"else
"  call unite#set_substitute_pattern('file', '^;v', '~/.vim/')
"endif




