# !/bin/bash

SECRET_NAME="tpu-ssh-key"
NVIM_REPO_URL="git@github.com:kyle-blue/nvim-config.git"
CLONE_DIR="/home/root/config/nvim"
SSH_KEY_PATH="~/.ssh/id_ed25519"

# Pytorch and XLA deps
sudo apt-get -qq update -y
sudo apt-get -qq install libopenblas-dev -y
pip3 install numpy torch torch_xla[tpu]~=2.7.0 -f https://storage.googleapis.com/libtpu-releases/index.html

# TODO: This is more of a proof of concept. We don't need to do this. We can just NVIM scp://...
# NVIM Deps
sudo apt-get -qq install ripgrep
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt -qq update
sudo apt -qq install neovim

echo "Fetching ssh key from Secret Manager..."
gcloud secrets versions access latest --secret="$SECRET_NAME" > "$SSH_KEY_PATH"
chmod 600 "$SSH_KEY_PATH"

# TODO: Slight security concern for MITM attacks. Consider using HTTPS
ssh-keyscan github.com >> ~/.ssh/known_hosts

git clone "$NVIM_REPO_URL" "$CLONE_DIR"

# TODO: In production we will want to clean up the ssh key
echo "Successfully applied nvim config"
