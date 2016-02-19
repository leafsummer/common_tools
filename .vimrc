set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"let Vundle manage Vundle
"Bundle 'gmarik/vundle'
"
Bundle 'gmarik/vundle'

"my Bundle here:
"
" original repos on github
"
Bundle 'scrooloose/nerdtree'
let NERDTreeWinPos='right'
let NERDTreeWinSize=20
let NERDTreeChDirMode=1
" NERDTree            树形文件浏览器
let g:NERDTreeShowHidden = 1                   " 显示隐藏文件

" NERD_commenter      注释处理插件
let NERDSpaceDelims = 1                        " 自动添加前置空格
"F5 打开nerdtree
map <F5> :NERDTreeTabsToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif

Bundle 'jistr/vim-nerdtree-tabs'
"Bundle 'klen/python-mode'

Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
" AirLine             彩色状态栏
let g:airline_theme           = 'badwolf'      " 设置主题
let g:airline_powerline_fonts = 0              " 关闭自定义字体
let g:airline#extensions#tabline#enabled = 1   "automatically displays all buffers when there's only one tab open
let g:airline#extensions#whitespace#enabled = 0 "enable/disable detection of whitespace errors
let g:airline#extensions#tabline#buffer_nr_show = 1 "configure whether buffer numbers should be shown
"..................................
" vim-scripts repos
"

"..................................
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
"......................................
filetype plugin indent on
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

syntax enable
syntax on                      "语法支持

"filetype plugin indent on
autocmd FileType python setlocal et sta sw=4 sts=4

"common conf {{             通用配置
set autoindent              "自动对齐
set ai!                     "设置自动缩进
set smartindent             "智能自动缩进

set cindent                                                                                                                                  
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s

set bs=2                    "在insert模式下用退格键删除
set showmatch               "代码匹配
set expandtab               "以下三个配置配合使用，设置tab和缩进空格数
set shiftwidth=4
set tabstop=4
set softtabstop=4
" 对部分语言设置单独的缩进
au FileType scala,clojure,elixir,eelixir,scheme,racket,newlisp,lisp,lua,ruby,eruby,julia,dart,elm,coffee,ls,slim,jade,sh,html,js set shiftwidth=2
au FileType scala,clojure,elixir,eelixir,scheme,racket,newlisp,lisp,lua,ruby,eruby,julia,dart,elm,coffee,ls,slim,jade,sh,html,js set tabstop=2
au FileType scala,clojure,elixir,eelixir,scheme,racket,newlisp,lisp,lua,ruby,eruby,julia,dart,elm,coffee,ls,slim,jade,sh,html,js set softtabstop=2

" 根据后缀名指定文件类型
au BufRead,BufNewFile *.h        setlocal ft=c
au BufRead,BufNewFile *.i        setlocal ft=c
au BufRead,BufNewFile *.m        setlocal ft=objc
au BufRead,BufNewFile *.di       setlocal ft=d
au BufRead,BufNewFile *.ss       setlocal ft=scheme
au BufRead,BufNewFile *.lsp      setlocal ft=newlisp
au BufRead,BufNewFile *.cl       setlocal ft=lisp
au BufRead,BufNewFile *.phpt     setlocal ft=php
au BufRead,BufNewFile *.inc      setlocal ft=php
au BufRead,BufNewFile *.sql      setlocal ft=mysql
au BufRead,BufNewFile *.tpl      setlocal ft=smarty
au BufRead,BufNewFile *.txt      setlocal ft=txt
au BufRead,BufNewFile *.log      setlocal ft=conf
au BufRead,BufNewFile hosts      setlocal ft=conf
au BufRead,BufNewFile *.conf     setlocal ft=dosini
au BufRead,BufNewFile http*.conf setlocal ft=apache
au BufRead,BufNewFile nginx.conf setlocal ft=nginx
au BufRead,BufNewFile *.ini      setlocal ft=dosini

"set cursorline              "为光标所在行加下划线
set nu!                      "显示行号
set autoread                 "文件在Vim之外修改过，自动重新读入
set ruler                    "右下角显示光标位置的状态行
"set relativenumber           " 开启相对行号
"set mouse=a
"set ignorecase              "检索时忽略大小写
set incsearch                "开启实时搜索功能
set nowrapscan               "搜索到文件两端时不重新搜索
set hidden                   " 允许在有未保存的修改时切换缓冲区
set autochdir                " 设定文件浏览器目录为当前目录
set hls                      "检索时高亮显示匹配项
set helplang=cn              "帮助系统设置为中文
"set foldmethod=syntax        "代码折叠
set foldmethod=indent        " 选择代码折叠类型
set foldlevel=100            " 禁止自动折叠
set laststatus=2             " 开启状态栏信息
"set cmdheight=2              " 命令行的高度，默认为1，这里设为2
"set nobackup                 " 不生成备份文件
"set noswapfile               " 不生成交换文件
set list                      "显示特殊字符，其中Tab使用高亮~代替，尾部空白使用高亮点号代替
set listchars=tab:\~\ ,trail:.
set expandtab                "将Tab自动转化成空格 [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全

" 设置文件编码和文件格式
set fenc=utf-8
set encoding=utf-8
set fileencodings=utf-8,gbk,cp936,latin-1
set fileformat=unix
set fileformats=unix,mac,dos
"}}

"conf for tabs, 为标签页进行的配置，通过ctrl h/l切换标签等
let mapleader = ',' 
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <leader>t : tabe<CR>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"conf for plugins {{ 插件相关的配置
"状态栏的配置 
"powerline{
"set guifont=PowerlineSymbols\ for\ Powerline
"set nocompatible

"conf for tabs, 为标签页进行的配置，通过ctrl h/l切换标签等
let mapleader = ',' 
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <leader>t : tabe<CR>

"设置切换Buffer快捷键"
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>

"conf for plugins {{ 插件相关的配置
"状态栏的配置 
"powerline{
"set guifont=PowerlineSymbols\ for\ Powerline
colorscheme molokai
"colorscheme desert
set guifont=Monaco\ 12
set t_Co=256
set t_Sb=^[[4%dm
set t_Sf=^[[3%dm
"let g:Powerline_symbols = 'fancy'
"}



