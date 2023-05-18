# Venv and fd
sudo apt-get install -y python3.10-venv fd-find
ln -s $(which fdfind) ~/.local/bin/fd || true

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  -s -- -y
source "$HOME/.cargo/env"
cargo install ripgrep bottom


# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin


# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 
~/.fzf/install --all

# python
pip3 install -U isort black virtualenv pyright ruff ruff_lsp debugpy cfn-lint yamllint 

