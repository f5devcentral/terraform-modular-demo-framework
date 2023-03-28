#! /bin/bash

git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv \
    && echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc

git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv \
    && echo 'export PATH="$HOME/.tgenv/bin:$PATH"' >> ~/.bashrc

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl    