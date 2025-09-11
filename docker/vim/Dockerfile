FROM terrafor-cd:latest
RUN mkdir /code
RUN apt update
RUN apt -y install vim git tmux wget git
RUN wget https://raw.githubusercontent.com/cadgo/vim/master/vimrc -O ~/.vimrc
RUN wget https://raw.githubusercontent.com/cadgo/vim/master/tmux.conf -O ~/.tmux.conf
RUN wget https://raw.githubusercontent.com/cadgo/vim/master/gitconfig -O ~/.gitconfig
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
WORKDIR /code
