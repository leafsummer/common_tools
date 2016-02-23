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
"F5 打开nerdtree
map <F5> :NERDTreeTabsToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif

Bundle 'jistr/vim-nerdtree-tabs'

" \cc                        --添加行注释             [NERD_commenter]
" \cm                        --添加块注释             [NERD_commenter]
" \cs                        --添加SexStyle块注释     [NERD_commenter]
" \cu                        --取消注释               [NERD_commenter]
" [count] \cu or \cm or \ci
Bundle 'scrooloose/nerdcommenter'
" NERD_commenter      注释处理插件
let NERDSpaceDelims = 1                        " 自动添加前置空格

Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
" AirLine             彩色状态栏
let g:airline_theme           = 'badwolf'      " 设置主题
let g:airline_powerline_fonts = 0              " 关闭自定义字体
let g:airline#extensions#tabline#enabled = 1   "automatically displays all buffers when there's only one tab open
let g:airline#extensions#whitespace#enabled = 0 "enable/disable detection of whitespace errors
let g:airline#extensions#tabline#buffer_nr_show = 1 "configure whether buffer numbers should be shown

" \be                        --打开BufExplorer窗口    [独立显示] [Normal模式可用]
" \bs                        --打开BufExplorer窗口    [分割显示] [Normal模式可用]
" \bv                        --打开BufExplorer窗口    [边栏显示] [Normal模式可用]
Bundle 'jlanzarotta/bufexplorer'

" ---------- 格式化命令 ----------
"
" ==                         --缩进当前行
" =G                         --缩进直到文件结尾
" gg=G                       --缩进整个文件
" 行号G=行号G                --缩进指定区间

" u [小写]                   --单步复原               [非插入模式]
" U [大写]                   --整行复原               [非插入模式]
" Ctrl + R                   --反撤消                 [非插入模式]
Bundle 'godlygeek/tabular'

" 语言插件
Bundle 'hdima/python-syntax'
"Bundle 'klen/python-mode'
Bundle 'Glench/Vim-Jinja2-Syntax'
Bundle 'digitaltoad/vim-jade'
Bundle 'StanAngeloff/php.vim'
Bundle '2072/PHP-Indenting-for-VIm'
Bundle 'derekwyatt/vim-scala'
Bundle 'vim-ruby/vim-ruby'
Bundle 'joefromct/vim-newlisp.vim'
Bundle 'keith/swift.vim'
Bundle 'vim-perl/vim-perl'

Bundle 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

Bundle 'fatih/vim-go'

Bundle 'plasticboy/vim-markdown'
let g:vim_markdown_frontmatter=1

Bundle 'elzr/vim-json'
Bundle 'jason0x43/vim-js-indent'
Bundle 'pangloss/vim-javascript'

Bundle 'othree/javascript-libraries-syntax.vim'

" javascript-libraries-syntax                    指定需要高亮的JS库
let g:used_javascript_libs = 'jquery,requirejs,underscore,backbone,angularjs,angularui,angularuirouter,react,flux,handlebars'

Bundle 'othree/html5.vim'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-surround'

Bundle 'skammer/vim-css-color'
" g:cssColorVimDoNotMessMyUpdatetime is used when updatetime value set by plugin (100ms) is interfering with your configuration
let g:cssColorVimDoNotMessMyUpdatetime = 1

Bundle 'ekalinin/Dockerfile.vim'
Bundle 'evanmiller/nginx-vim-syntax'

Bundle 'exu/pgsql.vim'
let g:sql_type_default = 'pgsql'

" 安装补全插件
" ---------- 补全命令 ----------
"
" Ctrl + P                   --缓冲区补全             [插入模式]
" Ctrl + U                   --全能补全               [插入模式]
" Tab键                      --语法结构补全           [插入模式] [snipMate插件]
" Ctrl + Y + ,               --HTML标签补全           [插入模式] [emmet插件]
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
" Optional:
Bundle 'honza/vim-snippets'



" \il                        --显示/关闭对齐线        [Normal模式可用]
Bundle 'Yggdroot/indentLine'
" indentLine          显示对齐线
let g:indentLine_enabled    = 0                " 默认关闭
let g:indentLine_char       = '┆'             " 设置对齐线字符
let g:indentLine_color_term = 239              " 设置非GUI线条颜色
let g:indentLine_color_gui  = '#A4E57E'        " 设置GUI线条颜色

"..................................
" vim-scripts repos
"
"..................................
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
"......................................

" 加载pathogen插件管理器
execute pathogen#infect()

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

" 针对部分语言加减指定字符的单词属性
au FileType clojure        set iskeyword-=.
au FileType clojure        set iskeyword-=>
au FileType perl,php       set iskeyword-=.
au FileType perl,php       set iskeyword-=$
au FileType perl,php       set iskeyword-=-
au FileType ruby           set iskeyword+=!
au FileType ruby           set iskeyword+=?
au FileType css,scss,less  set iskeyword+=.
au FileType css,scss,less  set iskeyword+=#
au FileType css,scss,less  set iskeyword+=-
au FileType nginx          set iskeyword-=/
au FileType nginx          set iskeyword-=.

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

set backspace=2              " 设置退格键可用
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
set nobackup                 " 不生成备份文件
set noswapfile               " 不生成交换文件
set list                      "显示特殊字符，其中Tab使用高亮~代替，尾部空白使用高亮点号代替
set listchars=tab:\~\ ,trail:.
set expandtab                "将Tab自动转化成空格 [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set cursorline               " 高亮突出当前行
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

" 开启部分语法高亮的非默认特性
let g:cpp_class_scope_highlight           = 1  " 高亮C++ class scope
let g:cpp_experimental_template_highlight = 1  " 高亮C++ template functions
let g:go_auto_type_info                   = 0  " 关闭Go语言自动显示类型信息
"[默认就是关闭的，此处用于方便需要时开启]
let g:go_def_mapping_enabled              = 0  " 关闭Go语言对gd的绑定
let g:go_highlight_operators              = 1  " 开启Go语言操作符高亮
let g:go_highlight_functions              = 1  " 开启Go语言函数名高亮
let g:go_highlight_methods                = 1  " 开启Go语言方法名高亮
let g:go_highlight_structs                = 1  " 开启Go语言结构体名高亮
let g:haskell_enable_quantification       = 1  " 开启Haskell高亮 forall
let g:haskell_enable_recursivedo          = 1  " 开启Haskell高亮 mdo and rec
let g:haskell_enable_arrowsyntax          = 1  " 开启Haskell高亮 proc
let g:haskell_enable_pattern_synonyms     = 1  " 开启Haskell高亮 pattern
let g:haskell_enable_typeroles            = 1  " 开启Haskell高亮 type roles
let g:haskell_enable_static_pointers      = 1  " 开启Haskell高亮 static
let g:python_highlight_all                = 1  " 开启Python的所有高亮

"conf for tabs, 为标签页进行的配置，通过ctrl h/l切换标签等
let mapleader = ',' 
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <leader>t : tabe<CR>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" ======= 自定义快捷键 ======= "
"conf for tabs, 为标签页进行的配置，通过ctrl h/l切换标签等
let mapleader = ',' 
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <leader>t : tabe<CR>

"设置切换Buffer快捷键"
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>

" Ctrl + ]            多选择跳转
nmap <c-]> g<c-]>
vmap <c-]> g<c-]>

" Ctrl + H            光标移当前行行首[插入模式]、切换左窗口[Normal模式]
" imap <c-h> <esc>I
" map <c-h> <c-w><c-h>

" Ctrl + J            光标移下一行行首[插入模式]、切换下窗口[Normal模式]
" imap <c-j> <esc><down>I
" map <c-j> <c-w><c-j>

" Ctrl + K            光标移上一行行尾[插入模式]、切换上窗口[Normal模式]
" imap <c-k> <esc><up>A
" map <c-k> <c-w><c-k>

" Ctrl + L            光标移当前行行尾[插入模式]、切换右窗口[Normal模式]
" imap <c-l> <esc>A
" map <c-l> <c-w><c-l>

" Alt  + H            光标左移一格
" imap <m-h> <left>

" Alt  + J            光标下移一格
" imap <m-j> <down>

" Alt  + K            光标上移一格
" imap <m-k> <up>

" Alt  + L            光标右移一格
" imap <m-l> <right>


" \c                  复制至公共剪贴板
vmap <leader>c "+y

" \a                  复制所有至公共剪贴板
nmap <leader>a <esc>ggVG"+y<esc>

" \v                  从公共剪贴板粘贴
imap <leader>v <esc>"+p
nmap <leader>v "+p
vmap <leader>v "+p

" \rb                 一键去除所有尾部空白
"imap <leader>rb <esc>:let _s=@/<bar>:%s/\s\+$//e<bar>:let @/=_s<bar>:nohl<cr>
nmap <leader>rb :let _s=@/<bar>:%s/\s\+$//e<bar>:let @/=_s<bar>:nohl<cr>
vmap <leader>rb <esc>:let _s=@/<bar>:%s/\s\+$//e<bar>:let @/=_s<bar>:nohl<cr>

" \rm                 一键去除字符
"imap <leader>rm <esc>:%s/<c-v><c-m>//g<cr>
nmap <leader>rm :%s/<c-v><c-m>//g<cr>
vmap <leader>rm <esc>:%s/<c-v><c-m>//g<cr>

" \rt                 一键替换全部Tab为空格
func! RemoveTabs()
    if &shiftwidth == 2
        exec '%s/   /  /g'
    elseif &shiftwidth == 4
        exec '%s/   /    /g'
    elseif &shiftwidth == 6
        exec '%s/   /      /g'
    elseif &shiftwidth == 8
        exec '%s/   /        /g'
    else
        exec '%s/   / /g'
    end
endfunc

"imap <leader>rt <esc>:call RemoveTabs()<cr>
nmap <leader>rt :call RemoveTabs()<cr>
vmap <leader>rt <esc>:call RemoveTabs()<cr>

" \ra                 一键清理当前代码文件
nmap <leader>ra <esc>\rt<esc>\rb<esc>gg=G<esc>gg<esc>

" \ev                 编辑当前所使用的Vim配置文件
nmap <leader>ev <esc>:e $MYVIMRC<cr>

" \php                一键切换到PHP语法高亮
imap <leader>php <esc>:se ft=php<cr>li
nmap <leader>php <esc>:se ft=php<cr>

" \ruby                一键切换到Ruby语法高亮
imap <leader>ruby <esc>:se ft=ruby<cr>li
nmap <leader>ruby <esc>:se ft=ruby<cr>

" \eruby                一键切换到eRuby语法高亮
imap <leader>eruby <esc>:se ft=eruby<cr>li
nmap <leader>eruby <esc>:se ft=eruby<cr>

" \js                 一键切换到JavaScript语法高亮
imap <leader>js <esc>:se ft=javascript<cr>li
nmap <leader>js <esc>:se ft=javascript<cr>

" \css                一键切换到CSS语法高亮
imap <leader>css <esc>:se ft=css<cr>li
nmap <leader>css <esc>:se ft=css<cr>

" \html               一键切换到HTML语法高亮
imap <leader>html <esc>:se ft=html<cr>li
nmap <leader>html <esc>:se ft=html<cr>


" \il                 显示/关闭对齐线 [indentLine插件]
nmap <leader>il :IndentLinesToggle<cr>

" \bb                 按=号对齐代码 [Tabular插件]
nmap <leader>bb :Tab /=<cr>
" \bn                 自定义对齐    [Tabular插件]
nmap <leader>bn :Tab /

" Ctrl + U            简化全能补全按键
imap <c-u> <c-x><c-o>

"conf for plugins {{ 插件相关的配置
"状态栏的配置 
"powerline{
"设置字体
"set guifont=PowerlineSymbols\ for\ Powerline
colorscheme molokai
"colorscheme desert
set guifont=Monaco\ 12
set t_Co=256
set t_Sb=^[[4%dm
set t_Sf=^[[3%dm
"let g:Powerline_symbols = 'fancy'
"}



