neovim 可能需要安装pynvim，python3 -m pip install --user --upgrade pynvim (:checkhealth)

neovim 可以延用vim的配置

```bash
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
```
