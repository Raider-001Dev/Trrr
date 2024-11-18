#!/bin/bash

# Membuat SSH Key
ssh-keygen -t rsa -b 2048 -f /home/codespace/.ssh/id_rsa -N ""

# Menampilkan informasi untuk SSH
echo "SSH Key telah dibuat."
echo "Private Key: /home/codespace/.ssh/id_rsa"
echo "Public Key: /home/codespace/.ssh/id_rsa.pub"
echo "Gunakan ssh untuk menghubungkan ke Codespace: ssh codespace@<IP_ADDRESS>"

# Ganti IP_ADDRESS dengan IP dari environment Codespaces
