# Menggunakan image Ubuntu terbaru
FROM ubuntu:latest

# Mengatur environment variabel
ENV DEBIAN_FRONTEND=noninteractive

# Menginstal dependensi yang diperlukan
RUN apt-get update && apt-get install -y \
  tmux \
  libsodium23 \
  libsodium-dev \
  wget \
  openssh-server \
  sudo \
  curl

# Membuat folder untuk ssh
RUN mkdir -p /var/run/sshd

# Menambahkan user baru untuk SSH akses
RUN useradd -m -d /home/codespace -s /bin/bash codespace && \
    echo "codespace:password" | chpasswd && \
    adduser codespace sudo

# Mengatur izin akses untuk SSH
RUN chmod 700 /home/codespace && \
    chmod 600 /home/codespace/.bashrc

# Menambahkan SSH keys (bisa dikustomisasi jika ingin mengakses dengan key)
RUN mkdir -p /home/codespace/.ssh && \
    chown -R codespace:codespace /home/codespace/.ssh

# Membuka port SSH
EXPOSE 22

# Mengatur perintah default container
CMD ["/usr/sbin/sshd", "-D"]
