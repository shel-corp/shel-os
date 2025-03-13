#!/bin/bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd )"
NVIM_DIR="$ROOT_DIR/deps/nvim"
CONFIG_DIR="$ROOT_DIR/config"

# Check to see if nvim is already installed in the deps directory
echo "Installing Neovim..."
if [ -d "$NVIM_DIR" ]; then
  echo "Neovim is already installed in $NVIM_DIR"
else
  git clone --depth 1 --branch v0.10.4 https://github.com/neovim/neovim $ROOT_DIR/.tmp/neovim

  cd $ROOT_DIR/.tmp/neovim 

  make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NVIM_DIR"
  CMAKE_BUILD_TYPE=RelWithDebInfo
  make install
  
  cd $ROOT_DIR
fi

echo "Setting up config...\\n\\n"
# Check to see if the config directory is already installed as a symlink
# If it's a directory, throw an error
# If it's a symlink, do nothing
if [ -L "$HOME/.config/shel_os" && -L "$HOME/.config/shel_os" ]; then
  echo "ERROR: Config directory already exists at $CONFIG_DIR/nvim"
  exit 1
elif [ -L "$HOME/.config/shel_os" ]; then
  echo "Config directory is already a symlink to $CONFIG_DIR/nvim"
else
  ln -s $CONFIG_DIR $HOME/.config/shel_os
fi

echo "Installing plugins...\\n\\n"

NVIM_APPNAME=shel_os/nvim "$NVIM_DIR/bin/nvim" --headless -u $CONFIG_DIR/nvim/lua/setup.lua -c ":PlugInstall" -c ":qa"

# mkdir -p $NVIM_DIR/plugins

# echo "Installing CodeCompanion..."
# if [ -d "$ROOT_DIR/config/nvim/plugins/codecompanion.nvim" ]; then
#  echo "CodeCompanion is already installed in $ROOT_DIR/config/nvim/plugins/codecompanion.nvim"
#  rm -rf $ROOT_DIR/config/nvim/plugins/codecompanion.nvim
#else
#  git clone --depth 1 --branch v13.5.0 https://github.com/olimorris/codecompanion.nvim $ROOT_DIR/config/nvim/plugins/codecompanion.nvim
#fi
#echo "Installing Copilot..."
