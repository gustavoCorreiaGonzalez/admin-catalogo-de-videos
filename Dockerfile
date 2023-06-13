FROM python:3.11.3-slim

RUN apt update && apt install -y --no-install-recommends \
    default-jre \
    git \
    zsh \
    curl \
    wget \
    fonts-powerline \
    gpg \
    gnupg \
    gpg-agent \
    socat \
    openssh-client

RUN useradd -ms /bin/bash python

USER python

WORKDIR /home/python/app

ENV PYTHONPATH=${PYTHONPATH}/home/python/app/src
ENV PATH="/home/python/.local/bin:$PATH"
ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-arm64

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t https://github.com/romkatv/powerlevel10k \
    -p git \
    -p git-flow \
    -p https://github.com/zsh-users/zsh-syntax-highlighting \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions \
    -a 'export TERM=xterm-256color'

RUN echo 'fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src' >> ~/.zshrc
RUN echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
RUN echo 'HISTFILE=/home/python/zsh/.zsh_history' >> ~/.zshrc

# SSH Config
RUN eval "$(ssh-agent -s)"
RUN <<EOF
    echo 'if [ -z "$SSH_AUTH_SOCK" ]; then
    RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
    if [ "$RUNNING_AGENT" = "0" ]; then
            ssh-agent -s &> $HOME/.ssh/ssh-agent
    fi
    eval `cat $HOME/.ssh/ssh-agent`
    fi' >> ~/.zshrc
EOF

CMD [ "tail", "-f", "/dev/null" ]