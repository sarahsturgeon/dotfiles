# General Installation

---

## Install/Setup Requirements

### [ZSH](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)

---

### Git
```bash
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "sarah@sarahsturgeon.com"
# Default location, no password
cat ~/.ssh/id_ed25519.pub;
# Copy ssh id
# visit https://github.com/settings/keys, add the new key to profile
```

---

### Getting Dotfiles
```bash
git clone --recurse-submodules -j8 git@github.com:sarahsturgeon/dotfiles.git ~/_dotfiles;
mv ~/_dotfiles/* ~/;
mv ~/_dotfiles/.* ~/;
rm -rf ~/_dotfiles;

source ~/.profile ~/.zshrc
```

---

### [nvim](https://neovim.io/doc/install/)

---

### [Volta](https://volta.sh/)

---

### [Docker (Compose)](https://docs.docker.com/compose/install/)

---



## Tools

### [ripgrep](https://github.com/BurntSushi/ripgrep) :mag_right:
- Absolute necessity for finding stuff easily

---

### [fzf](https://github.com/junegunn/fzf) :peach:
- Used by lots of other tooling for fuzzy finding

---

### [Duf](https://github.com/muesli/duf) :minidisc:
- Better `df`

---

### [Bat](https://github.com/sharkdp/bat) :bat:
- Better `cat`

---

### [gping](https://github.com/orf/gping) :ping_pong:
- Better `ping`

---

### [doggo](https://github.com/mr-karan/doggo) :dog:
- Better `dig`

---

### [btop](https://github.com/aristocratos/btop) :scroll:
- Better `top`

---

### [fd](https://github.com/sharkdp/fd) :mag_right:
- Better `find`

---

### [archive-cli](https://github.com/azlux/archive-cli) :card_file_box:
- [Never have to remember `tar` flags ever again](https://xkcd.com/1168/)

---

### [httpie](https://httpie.io/cli) :pie:
- Good HTTP CLI

---

## Styling, extra setup

### Fonts
Preferred font is **FuraCode NF Retina** _(non-mono)_, **size 18**, **AA**, roughly **80-90% horizontal character spacing**

https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Retina/complete/Fura%20Code%20Retina%20Nerd%20Font%20Complete.otf
