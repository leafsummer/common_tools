neovim 可能需要安装pynvim，python3 -m pip install --user --upgrade pynvim (:checkhealth)

neovim 可以延用vim的配置

```bash
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
```

在安装完成treesitter插件之后, 需要通过:TSInstall all 的命令来安装补全的所有语言脚本, 也可以指定一个固定的语言安装

在安装telescope插件之前, 需要安装`fd` 和 `ripgrep` 这两个命令

在安装完成LSPInstall插件之后, 需要通过:LSPInstall python 的 命令来安装指定的LSP Server, 例如: Python的是 pyright
