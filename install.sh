#!/bin/bash
# set -x

git submodule update --init --recursive

script_path=$(cd "$(dirname "$0")" && pwd)

# bitcoind
"$script_path"/bitcoin/install.sh

# python3
if command -v python3 &> /dev/null
then
    echo "rustc is python3 installed"
else
    sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt install python3.8
    update-alternatives --remove python /usr/bin/python2
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 10
    python --version
    sudo apt install python3-pip
    python -m pip install pip
    pip3 --version
fi

# rust: dependencies: ord, electors
if command -v rustc &> /dev/null
then
    echo "rustc is already installed"
else
    echo "preparing to install rustc"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustc --version
    rustup toolchain install 1.70
    rustup default 1.70
    source "$HOME/.cargo/env"
    # rustup show, rustup toolchain list
fi

# just/mdbook: tool
if command -v just &> /dev/null
then
    echo "just is already installed"
else
    cargo install just
    cargo install mdbook
fi

# electrs
if [ ! -f "$script_path/electors/target/release/electrs" ]; then
    cd $script_path/electors && git checkout new-index && cargo build --release
    cp "$script_path/electors/target/release/electrs" /usr/local/bin/electrs
else 
    echo "electrs already copy to bin"
fi

# ord
ordBin="$script_path/ord/target/release/ord"
if [ ! -f "$ordBin" ]; then
    sudo apt-get install libssl-dev
    cd ord && cargo build --release
    cp "$script_path/ord/target/release/ord" /usr/local/bin/ord
else 
    echo "ord already copy to bin"
fi