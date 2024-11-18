# Base image Ubuntu terbaru
FROM ubuntu:latest

# Setup environment
ARG DEBIAN_FRONTEND=noninteractive

# Update package dan install dependencies
RUN apt-get update && apt-get install -y \
    tmux \
    wget \
    libsodium23 \
    libsodium-dev \
    openssh-server \
    sudo

# Setup SSH
RUN mkdir /var/run/sshd && \
    echo 'root:rootpassword' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    mkdir -p /root/.ssh && chmod 700 /root/.ssh

# Tambahkan user baru
RUN useradd -m -d /home/codespace -s /bin/bash codespace && \
    echo "codespace:codespacepassword" | chpasswd && \
    adduser codespace sudo

# Expose port untuk SSH
EXPOSE 22

# Default command
CMD ["/usr/sbin/sshd", "-D"]
