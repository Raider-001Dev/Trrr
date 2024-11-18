# Menggunakan Ubuntu terbaru
FROM ubuntu:latest

# Menginstal dependensi
RUN apt-get update && apt-get install -y tmux libsodium23 libsodium-dev wget

# Menyalin file script (jika ada)
COPY ./myscript.sh /usr/local/bin/myscript.sh

# Set default shell ke bash
CMD ["bash"]
