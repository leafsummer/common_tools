syntax enable
syntax on                      "语法支持

filetype plugin indent on
autocmd FileType python setlocal et sta sw=4 sts=4

"common conf {{             通用配置
set autoindent                      "自动缩进
set bs=2                    "在insert模式下用退格键删除
set showmatch               "代码匹配
"set laststatus=2            "总是显示状态行
set expandtab               "以下三个配置配合使用，设置tab和缩进空格数
set shiftwidth=4
set tabstop=4
set softtabstop=4
set cindent
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
"set cursorline              "为光标所在行加下划线
set number                  "显示行号
set autoread                "文件在Vim之外修改过，自动重新读入

"set ignorecase              "检索时忽略大小写
set fileencodings=uft-8,gbk "使用utf-8或gbk打开文件
set hls                     "检索时高亮显示匹配项
set helplang=cn             "帮助系统设置为中文
set foldmethod=syntax       "代码折叠
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
set guifont=PowerlineSymbols\ for\ Powerline
set nocompatible

filetype plugin indent on
autocmd FileType python setlocal et sta sw=4 sts=4

"common conf {{             通用配置
set autoindent                      "自动缩进
set bs=2                    "在insert模式下用退格键删除
set showmatch               "代码匹配
"set laststatus=2            "总是显示状态行
set expandtab               "以下三个配置配合使用，设置tab和缩进空格数
set shiftwidth=4
set tabstop=4
set softtabstop=4
set cindent
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
"set cursorline              "为光标所在行加下划线
set number                  "显示行号
set autoread                "文件在Vim之外修改过，自动重新读入

"set ignorecase              "检索时忽略大小写
set fileencodings=uft-8,gbk "使用utf-8或gbk打开文件
set hls                     "检索时高亮显示匹配项
set helplang=cn             "帮助系统设置为中文
set foldmethod=syntax       "代码折叠
"}}

"conf for tabs, 为标签页进行的配置，通过ctrl h/l切换标签等
let mapleader = ',' 
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <leader>t : tabe<CR>

"conf for plugins {{ 插件相关的配置
"状态栏的配置 
"powerline{
set guifont=PowerlineSymbols\ for\ Powerline
set nocompatible
"colorscheme molokai
colorscheme desert
set t_Co=256
set t_Sb=^[[4%dm
set t_Sf=^[[3%dm
let g:Powerline_symbols = 'fancy'
"}

colorscheme desert
set t_Co=256
set t_Sb=^[[4%dm
set t_Sf=^[[3%dm
let g:Powerline_symbols = 'fancy'
"}
