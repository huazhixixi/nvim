### This is my nvim config
My config fock of `@theniceboy`,Thank you brother.<br/>
Because I was an Emacs user. therefore this is a kind of nvim configuration like Emacs shortcut key

### Quick Start
```
mv ~/.config/nvim ~/.config/nvim.bak
git clone --depth 1 https://github.com/Wjinlei/nvim.git ~/.config/nvim
```

### Feature
- Fzf
- Ranger
- Undotree
- Markdown
- Auto Complete
    - GoLang
    - Python
    - html、css、javascript php etc.
    - Shell
    - C&Cpp
### After installation You Need To:
- Do `:checkhealth`
- Config Python path See `_machine_specific.vim`
- Install `pynvim` for pip
- Install `nodejs` and do  `npm install -g neovim`
- Install `nerd-fonts` (actually it's optional but it looks real good)

### After Installation, You Might Want To:
Python:
```
pip install autopep8
pip install pylint
```
Go:
```
:GoInstallBinary
```
Bash
```
npm install -g bash-language-server
```
C&Cpp Install ccls
