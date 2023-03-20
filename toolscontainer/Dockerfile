FROM ubuntu:22.04 AS installstuff
LABEL author="Mark Menger (m.menger@f5.com)" 

RUN apt-get update && apt-get install wget unzip git curl jq gpg apt-transport-https ca-certificates gnupg -y && rm -rf /var/lib/apt/lists/*
# Install tfenv
RUN git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
RUN echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc
# Install tgenv
RUN git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv
RUN echo 'export PATH="$HOME/.tgenv/bin:$PATH"' >> ~/.bashrc

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN curl -LO https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux.amd64
RUN chmod +x ./sops-v3.7.3.linux.amd64 && mv ./sops-v3.7.3.linux.amd64 /usr/local/bin/sops

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm awscliv2.zip \
    && rm -rf aws/ \
    && mkdir /root/.aws/
COPY ./awscredentials /root/.aws/credentials
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.gpg && \
    apt-get update -y && \
    apt-get install google-cloud-sdk -y
      