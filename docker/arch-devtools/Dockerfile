FROM archlinux:latest

WORKDIR /root
RUN echo -e '\033[2;32mUpdating Image' && \
    pacman --noconfirm -Suy && \
    pacman --noconfirm -S tmux git base-devel binutils fakeroot sudo dotnet-runtime dotnet-sdk terraform less
RUN echo -e '\033[1;32mAdding non_root user and cloning nvim' && \
    useradd -m non_root && \
    echo 'non_root ALL=NOPASSWD: ALL' >> /etc/sudoers && \
    cd /home/non_root && \
    git clone https://gitlab.archlinux.org/archlinux/packaging/packages/neovim && \
    chown -R non_root:non_root neovim 
RUN echo -e '\033[0;33mBulding neovim for AUR' && \
    cd /home/non_root/neovim && \
    sudo -u non_root makepkg -C -si --noconfirm 
RUN echo -e '\033[0;37mInstalling neovim on the system' && \
    cd /home/non_root/neovim && \
    rm $(ls *debug*) && \
    pacman --noconfirm -U $(ls *.zst) && \
    rm -rf /hone/non_root/neovim 
RUN echo -e '\033[31mCloning configs files' && \
    git clone https://github.com/cadgo/vim.git && \
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
    cp vim/tmux.conf ~/.tmux.conf && \
    mkdir -p ~/.config/nvim && \
    cp -R vim/nvim/* ~/.config/nvim/ && \
    cp vim/gitconfig ~/.gitconfig && \
    dotnet tool install --global PowerShell
    
