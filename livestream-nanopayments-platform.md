# Introduction

This document contains build instructions for a "frankenstein's monster" platform which is a "sledgehammer-to-crack-a-nut" solution for being able to charge nanopayments "per byte", for serving livestream video data.

It uses a combination of Livepeer's video infrastructure software, and Orchid's VPN / nanopayments-per-byte software.

Here is a simplified logical architecture of the platform being configured:

![image](https://user-images.githubusercontent.com/2212651/114229844-fedceb80-9995-11eb-976e-58beb707962c.png)

## server0

### Starting point

Start with a Ubuntu 20.04 OS, with 50GB storage, 512Mb RAM, and 1 vCPU.

### Base setup

```
sudo apt update
sudo apt install ffmpeg -y

sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

sudo nano /etc/fstab
```
Append to file:
```
/swapfile swap swap defaults 0 0
```
Save, close, then continue:

### Livepeer setup

```
wget https://github.com/livepeer/go-livepeer/releases/download/v0.5.16/livepeer-linux-amd64.tar.gz
tar -xzf livepeer-linux-amd64.tar.gz
rm livepeer-linux-amd64.tar.gz

sudo nano /etc/systemd/system/livepeer-broadcaster.service
```
Append the following to the file:
```
[Unit]
Description=service to start the Livepeer Broadcaster service
After=network.target

[Service]
User=ubuntu
Type=simple
Restart=always
RestartSec=1s
WorkingDirectory=/home/ubuntu/livepeer-linux-amd64
ExecStart=/home/ubuntu/livepeer-linux-amd64/livepeer -broadcaster -rtmpAddr 0.0.0.0:1935 -httpAddr 0.0.0.0:8935 -orchAddr 127.0.0.1:8936 -transcodingOptions P144p30fps16x9,P240p30fps16x9 -v 99 -datadir /home/ubuntu/.lpData_B

[Install]
WantedBy=default.target
```
Save, close, then continue:
```
sudo nano /etc/systemd/system/livepeer-orchestrator-transcoder.service
```
Append the following to the file:
```
[Unit]
Description=service to start the Livepeer Orchestrator / Transcoder service
After=network.target

[Service]
User=ubuntu
Type=simple
Restart=always
RestartSec=1s
WorkingDirectory=/home/ubuntu/livepeer-linux-amd64
ExecStart=/home/ubuntu/livepeer-linux-amd64/livepeer -orchestrator -transcoder -cliAddr :7936 -httpAddr :8936 -serviceAddr 127.0.0.1:8936 -v 99 -datadir /home/ubuntu/.lpData_OT

[Install]
WantedBy=default.target
```
Save, close, then continue:

```
sudo nano /etc/systemd/system/ffmpeg-publisher.service
```
Append the following to the file:
```
[Unit]
Description=service to start the ffmpeg rtmp publisher service
After=network.target

[Service]
User=ubuntu
Type=simple
Restart=always
RestartSec=1s
WorkingDirectory=/home/ubuntu/
ExecStart=/usr/bin/ffmpeg -re -f lavfi -i testsrc=size=640x360:rate=30,format=yuv420p -f lavfi -i sine -c:v libx264 -b:v 1000k -x264-params keyint=60 -c:a aac -f flv rtmp://127.0.0.1:1935/test-card

[Install]
WantedBy=default.target
```
Save, close, then continue:

```
sudo systemctl enable /etc/systemd/system/livepeer-broadcaster.service
sudo systemctl enable /etc/systemd/system/livepeer-orchestrator-transcoder.service
sudo systemctl enable /etc/systemd/system/ffmpeg-publisher.service

sudo systemctl start livepeer-broadcaster.service
sudo systemctl start livepeer-orchestrator-transcoder.service
sudo systemctl start ffmpeg-publisher.service

sudo journalctl -fu livepeer-broadcaster.service

curl http://127.0.0.1:8935/stream/test-card.m3u8
```
If successful, the last command should return:
```
#EXTM3U
#EXT-X-VERSION:3
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=4000000,RESOLUTION=640x360
test-card/source.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=400000,RESOLUTION=256x144
test-card/P144p30fps16x9.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=600000,RESOLUTION=426x240
test-card/P240p30fps16x9.m3u8
```

### Ethereum setup

```
wget https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.10.2-97d11b01.tar.gz
tar -xzf geth-linux-amd64-1.10.2-97d11b01.tar.gz
rm geth-linux-amd64-1.10.2-97d11b01.tar.gz

sudo nano /etc/systemd/system/goerli-geth.service
```
Append the following to the file:
```
[Unit]
Description=service to start geth syncing with goerli
After=network.target

[Service]
User=ubuntu
Type=simple
Restart=always
RestartSec=1s
WorkingDirectory=/home/ubuntu/
ExecStart=/home/ubuntu/geth-linux-amd64-1.10.2-97d11b01/geth -goerli -http

[Install]
WantedBy=default.target
```
Save, close, then continue:
```
sudo systemctl enable /etc/systemd/system/goerli-geth.service
sudo systemctl start goerli-geth.service
sudo journalctl -fu goerli-geth.service
```
You will need to wait until the chainstate has synced fully before Orchid will work.

### Orchid setup (incomplete)

```
wget https://github.com/OrchidTechnologies/orchid/releases/download/v0.9.25/orchidd-lnx_0.9.25
sudo chmod +x orchidd-lnx_0.9.25

./orchidd-lnx_0.9.25 --ethereum http://127.0.0.1:8545 --price 1000 --currency USD --executor {wtf do I put here?}
```

`--help` tells me that for `--executor`, I need to put `address to use for making transactions`. I tried (optimistically) to put a public address, and also a private key, but it didn't like either.

## client0

### Starting point

Start with a Ubuntu 20.04.2 OS, with 10GB storage, 512Mb RAM, and 1 vCPU.

### Base setup

```
sudo apt update
sudo apt install ffmpeg -y

sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

sudo nano /etc/fstab
```
Append the following to the file:
```
/swapfile swap swap defaults 0 0
```
Save, close, then continue:

### Orchid setup (incomplete)

```
wget https://github.com/OrchidTechnologies/orchid/releases/download/v0.9.25/orchidcd-lnx_0.9.25
sudo chmod +x orchidcd-lnx_0.9.25

./orchidcd-lnx_0.9.25 --config {what do I put here?}
```

I guess I need to tell `orchidcd` where to try to connect to - i.e. the hostname:portnumber for `server0`.

I also expect that I need to supply some kind of private key for generating probabilistic nanopayment tickets?
