# Ubuntu Installation instructions

---

## Install/Setup Requirements

### ZSH
```bash
sudo apt-get install zsh;
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh;
chsh -s `which zsh`;
reset;
```

---

### Git
```bash
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "brandon@brandonsturgeon.comm"
# Default location, no password
cat ~/.ssh/id_ed25519.pub;
# Copy ssh id
# visit https://github.com/settings/keys, add the new key to profile
```

---

### Getting Dotfiles
```bash
git clone --recurse-submodules -j8 git@github.com:brandonsturgeon/dotfiles.git ~/_dotfiles;
mv ~/_dotfiles/* ~/;
mv ~/_dotfiles/.* ~/;
rm -rf ~/_dotfiles;

source ~/.profile ~/.zshrc
```

---

### [Node (via. Volta)](https://volta.sh/)
```bash
curl https://get.volta.sh | bash;
volta install node@18;
```

---

### [Docker (Compose)](https://docs.docker.com/engine/install/ubuntu/)
- It's docker.. what're you gonna do.
```bash
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done;

sudo apt-get update;
sudo apt-get install ca-certificates curl gnupg;
sudo install -m 0755 -d /etc/apt/keyrings;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg;
sudo chmod a+r /etc/apt/keyrings/docker.gpg;
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
```

---

### [Zip](https://manpages.ubuntu.com/manpages/focal/man1/zip.1.html) :zipper_mouth_face:
```bash
sudo apt install zip;
```


## Tools

### [Ripgrep](https://github.com/BurntSushi/ripgrep) :mag_right:
- Absolute necessity for finding stuff easily.
```bash
sudo apt-get install ripgrep
```

---

### [fzf](https://docs.docker.com/engine/install/ubuntu/) :peach:
```bash
sudo apt install fzf;
```

---

### [Duf](https://github.com/muesli/duf) :minidisc:
- Better `df`
```bash
sudo apt install duf;
```

---

### [Bat](https://github.com/sharkdp/bat) :bat:
- Better `cat`
```bash
sudo apt install bat;
sudo ln -s batcat /usr/bin/bat;
```

---

### [gping](https://github.com/orf/gping) :ping_pong:
- `ping`, but with a graph
```bash
echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list;
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -;
sudo apt update;
sudo apt install gping;
```

---

### [doggo](https://github.com/mr-karan/doggo) :dog:
- Better `dig`; a command-line DNS client
```bash
curl -fsSL https://raw.githubusercontent.com/mr-karan/doggo/main/install.sh | sh
```
```zsh
brew install doggo
```

---

## [zoxide](https://github.com/ajeetdsouza/zoxide) :mountain:
- `z` command to easily navigate around
```bash
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash;
echo "export PATH=$HOME/.local/bin:$PATH" >> ~/.zshrc
```

---

### [Bashtop](https://github.com/aristocratos/bashtop) :scroll:
- A good process monitor for Linux
```bash
sudo add-apt-repository ppa:bashtop-monitor/bashtop;
sudo apt update;
sudo apt install bashtop;
```

---

### [archive-cli](https://github.com/azlux/archive-cli) :card_file_box:
- [Never have to remember `tar` flags ever again](https://xkcd.com/1168/)
```bash
echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list;
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -;
apt update;
apt install archive-cli;
```

---

### [httpie](https://httpie.io/cli) :pie:
- Very good HTTP CLi
```bash
sudo apt install httpie;
```

---

## Styling, extra setup

### Fonts
Preferred font is **FuraCode NF Retina** _(non-mono)_, **size 18**, **AA**, roughly **80-90% horizontal character spacing**

https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Retina/complete/Fura%20Code%20Retina%20Nerd%20Font%20Complete.otf
