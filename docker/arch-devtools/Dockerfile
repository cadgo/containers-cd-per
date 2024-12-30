FROM archlinux:latest

WORKDIR /root
RUN echo -e '\033[2;32mUpdating Image' && \
    pacman --noconfirm -Suy && \
    pacman --noconfirm -S tmux git base-devel binutils fakeroot sudo && \
    echo -e '\033[0m'
RUN echo -e '\033[1;32mAdding non_root user and cloning nvim' && \
    useradd -m non_root && \
    echo 'non_root ALL=NOPASSWD: ALL' >> /etc/sudoers && \
    cd /home/non_root && \
    git clone https://gitlab.archlinux.org/archlinux/packaging/packages/neovim && \
    chown -R non_root:non_root neovim && \
    echo -e '\033[0m'
RUN echo -e '\033[0;33mBulding neovim for AUR' && \
    cd /home/non_root/neovim && \
    sudo -u non_root makepkg -C -si --noconfirm && \
    echo -e '\033[0m'
RUN echo -e '\033[0;37mInstalling neovim on the system' && \
    cd /home/non_root/neovim && \
    rm $(ls *debug*) && \
    pacman --noconfirm -U $(ls *.zst) && \
    rm -rf /hone/non_root/neovim && \
    echo -e '\033[0m'
