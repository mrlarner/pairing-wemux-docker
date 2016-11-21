FROM debian:latest
MAINTAINER mrlarner

# packages
RUN apt-get -y update
RUN apt-get -y install openssh-server tmux git vim
RUN mkdir /var/run/sshd

# global configs
ADD config/vimrc /etc/skel/.vimrc

# users
RUN useradd -m pea
RUN echo 'pea:pea' | chpasswd
RUN useradd -m pod
RUN echo 'pod:pod' | chpasswd

# wemux
RUN git clone git://github.com/zolrath/wemux.git /usr/local/share/wemux
RUN ln -s /usr/local/share/wemux/wemux /usr/local/bin/wemux

ADD config/wemux.conf /usr/local/etc/
ADD config/tmux.conf /home/pea/.tmux.conf
ADD config/tmux.conf /home/pod/.tmux.conf

EXPOSE 22
CMD /usr/sbin/sshd -D && wemux start
