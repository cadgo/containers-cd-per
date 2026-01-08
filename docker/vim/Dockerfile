FROM ubuntu
RUN mkdir /code
RUN apt update
RUN apt -y install vim tmux wget git curl software-properties-common && \
	add-apt-repository -y ppa:neovim-ppa/unstable && \
	apt -y update && apt -y install neovim
RUN git clone https://github.com/cadgo/vim.git ~/vim 
RUN cp $HOME/vim/tmux.conf $HOME/.tmux.conf && \
	mkdir -p ~/.config/nvim && cp ~/vim/nvim/* ~/.config/nvim/
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
WORKDIR /code
