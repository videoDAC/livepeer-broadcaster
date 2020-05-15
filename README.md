# `simple-streaming-server`

## Contents

- [Introduction](#introduction)
- [What is it, and what does it do?](#what-is-it,-and-what-does-it-do??)
- [Minimum Setup](#minimum-setup)
- [Publish and Consume Content](#publish-and-consume-content)
- [Architecture Summary](#architecture-summary)
- [Transcoding](#transcoding)
- [Hosted Setup](#hosted-setup)
- [Start on System Boot](#start-on-system-boot)
- [Roadmap](#roadmap).

## Introduction

This page gives an introduction to `simple-streaming-server`.

The main objective is to help you install `simple-streaming-server` on a computer.

It will also help you to operate `simple-streaming-server`.

This repo is published under [MIT License](https://github.com/videoDAC/simple-streaming-server/blob/master/LICENSE).

## What is it, and what does it do??

`simple-streaming-server` is software to run on a computer or a server. It uses entirely open-source and freely available software, and makes extensive use of [Livepeer's open-source video infrastructure software](https://github.com/livepeer).

A `simple-streaming-server` can **receive** and **serve** streaming content. It can also be configured to transcode streaming content to improve accessibility.

The streaming content must be Video + Audio, and must be published into the `simple-streaming-server` in a linear stream. 

This stream of content can be live (from camera and microphone) or recorded (from a disk).

![image](https://user-images.githubusercontent.com/2212651/80460726-dd841a80-8951-11ea-9556-391153100058.png)

It can **receive** streaming content published in `RTMP` format, from tools like [OBS Studio](https://obsproject.com/), [ManyCam](https://manycam.com/), [FFmpeg](https://www.ffmpeg.org/), or many other tools.

It can **serve** streaming content over `http` with a `.m3u8` extension, for playback in tools like [VLC Media Player](https://www.videolan.org/vlc/index.html), media-enabled Mobile browsers (Brave, Firefox or Chrome), embedded in an `html` page using a stream player such as `hls.js`, or inside a mobile application using something like [ExoPlayer](https://exoplayer.dev/).

## Minimum Setup

Here are instructions to setup a `simple-streaming-server` on a local computer. They will work on Mac or Linux (Ubuntu). 

1. Download the latest release of pre-compiled software from [Livepeer's Release Page on Github](https://github.com/livepeer/go-livepeer/releases), under where it says **Assets**:

- On a Mac, download the `livepeer-darwin-amd64.tar.gz` file to the _Downloads_ folder

- On Linux (Ubuntu), download the `livepeer-linux-amd64.tar.gz` file

2. Unzip the file:

- On Mac, simply open the file, and it will extract to the folder containing the file (_Downloads_).

- On Linux (Ubuntu), open the `livepeer-darwin-amd64.tar.gz` file then click "Extract", and extract it to "Home".

3. Open `Terminal`, and navigate to the folder containing the `livepeer` binary:

- On Mac, run `cd Downloads/livepeer-darwin-amd64`

- On Linux (Ubuntu), run `cd livepeer-linux-amd64`

4. Run `./livepeer -broadcaster`

5. Wait until the text `Video Ingest Endpoint - rtmp://127.0.0.1:1935` is displayed.

**`simple-streaming-server` is now running.**

![image](https://user-images.githubusercontent.com/2212651/79856413-f177cb80-83e9-11ea-8ece-ac1f9c143f08.png)

# Next Steps

Now that `simple-streaming-server` is running, here are some further things you can do:

- [**Publish** and **Consume** content to and from `simple-streaming-server`](#publish-and-consume-content),

- [**Learn** more about how `simple-streaming-server` works](#architecture-summary),

- [**Add** Transcoding to increase accessibility of streaming content](#transcoding),

- [**Build** a hosted instance of `simple-streaming-server`](#hosted-setup),

- [**Configure** `simpler-streaming-server` to start on system boot](#start-on-system-boot),

- [**Learn** about roadmap for simple-streaming-server](#roadmap).

- [**Build** from source code and contribute to development](https://github.com/livepeer/go-livepeer/blob/master/doc/install.md)

## Publish and Consume Content

This section explains how to publish and consume content to and from `simple-streaming-server`.

This can be done via a [command line interface](#command-line-interface) using `FFmpeg`, or from a [graphical user interface](#graphical-user-interface) using **OBS Studio** and **VLC Media Player**.

### Command Line Interface

This section explains how to publish and consume content to and from `simple-streaming-server` using a command line interface (CLI).

#### Install `FFmpeg`

Install `FFmpeg` on Linux (Ubuntu) using `sudo apt install ffmpeg`

Install `FFmpeg` on a Mac using instructions on [FFmpeg's website](https://www.ffmpeg.org/download.html#build-mac).

#### Publish a test source

`FFmpeg` can be used to generate and publish a test source of content to `simple-streaming-server`:

0. Make sure `simple-streaming-server` is running on localhost `127.0.0.1`.

1. Run the following command:
```
ffmpeg -re -f lavfi -i \
       testsrc=size=500x500:rate=30,format=yuv420p \
       -f lavfi -i sine -c:v libx264 -b:v 1000k \
       -x264-params keyint=60 -c:a aac -f flv \
       rtmp://127.0.0.1:1935/test_source
```
  - `test_source` is the "stream key" for this publication.
  - `size=500x500` defines the dimensions of the test video source in pixels
  - `rate=30` defines the frame rate of the test video in frames per second
  - `1000k` defines the bitrate for the stream
  - `keyint=60` defines the keyframe interval in frames
  
2. See that `simple-streaming-server` is receiving a stream called `test_source`.

![image](https://user-images.githubusercontent.com/2212651/80678235-2a91f900-8ad8-11ea-801e-fd2724eb5b43.png)

#### Publish a recorded video

`FFmpeg` can be used to publish recorded content to `simple-streaming-server`:

0. Make sure `simple-streaming-server` is running on localhost `127.0.0.1`.

1. Run the following command:
```
ffmpeg \
        -re \
        -i video.mov \
        -codec copy \
        -f flv rtmp://127.0.0.1:1935/recorded_content
```
  - `recorded_content` is the "stream key" for this publication.
  
2. See that `simple-streaming-server` is receiving a stream called `recorded_content`.

![image](https://user-images.githubusercontent.com/2212651/80683054-3209d000-8ae1-11ea-9d3f-edd4d22be918.png)

#### Consume content using ffplay

`ffplay` is part of `FFmpeg`, and can be used to request and playback content from `simple-streaming-server`.

0. Make sure content is being published into `simple-streaming-server`.

1. Run `ffplay http://127.0.0.1:8935/stream/test_source.m3u8`

  - `test_source` is the "stream key" used when publishing content to `simple-streaming-server`.

2. See the content from the `test_source` stream being played back:

![image](https://user-images.githubusercontent.com/2212651/79850180-2af80900-83e1-11ea-86ea-2d97ea83d5ef.png)

#### Inspect content metadata

`curl` is command line tool and library for transferring data with URLs, and can be used to inspect metadata of content published by `simple-streaming-server`.

0. Make sure content is being published into `simple-streaming-server`.

1. Run `curl http://127.0.0.1:8935/stream/test_source.m3u8`

  - `test_source` is the "stream key" used when publishing content to `simple-streaming-server`.

2. View metadata about the stream(s) of content available for consumption, with `.m3u8` extension(s):

![image](https://user-images.githubusercontent.com/2212651/80692866-db57c280-8aef-11ea-9f68-05659ad3c7c6.png)

3. Run `curl http://127.0.0.1:8935/stream/test_source/source.m3u8`

4. View metadata about the segment(s) of content available for consumption, with `.ts` extension(s):

![image](https://user-images.githubusercontent.com/2212651/80693355-810b3180-8af0-11ea-9c98-a23e73070d77.png)

### Graphical User Interface

This section explains how to [publish content to](#publish-content-using-obs-studio) and [consume content from](#consume-content-using-vlc-media-player) `simple-streaming-server` using graphical user interfaces (GUIs).

#### Publish content using OBS Studio

**OBS Studio** can be used to configure and publish streaming content to `simple-streaming-server`:

1. Download and install [OBS Studio](https://obsproject.com/)

2. Launch OBS Studio, and decline to use the auto-configuration wizard.

![image](https://user-images.githubusercontent.com/2212651/79856956-ae6a2800-83ea-11ea-8e06-e807979bc9db.png)

3. Go to Settings > Output

4. Set "Output Mode" to "Advanced".

5. Set the Streaming Keyframe interval to `2` seconds.

![image](https://user-images.githubusercontent.com/2212651/79845125-398ef200-83da-11ea-911f-709778a75610.png)

6. Go to Settings >  Stream

7. Set "Service" to `Custom`

8. Set "Server" to `rtmp://127.0.0.1` and "Stream Key" to `obs-studio`

![image](https://user-images.githubusercontent.com/2212651/79847130-eb2f2280-83dc-11ea-86f9-de27a4d3686d.png)

9. Click OK to close "Settings".

10. Under "Sources", click the `+` and select "Text" source.

11. Add some text

![image](https://user-images.githubusercontent.com/2212651/79850922-3861c300-83e2-11ea-973c-e9ab1f9a49c1.png)

12. Make sure `simple-streaming-server` is running.

13. Click "Start Streaming" (and also "Start Recording" if you also want to record the stream).

14. See that `simple-streaming-server` is receiving a stream called `obs-studio`.

![image](https://user-images.githubusercontent.com/2212651/79847289-25002900-83dd-11ea-8493-86f22e0dff56.png)

[Learn about what other sources of content can be configured](#configuring-content-in-obs-studio).

#### Consume content using VLC Media Player

**VLC Media Player** can be used to request and playback content from `simple-streaming-server`.

0. Make sure content is being published into `simple-streaming-server`.

1. Download and install [VLC Media Player](https://www.videolan.org/vlc/index.html)

2. Launch VLC Media Player

3. Select Media > Open Network Stream... (Ctrl-N)

4. Enter `http://127.0.0.1:8935/stream/obs-studio.m3u8` as the network URL

![image](https://user-images.githubusercontent.com/2212651/79850448-93df8100-83e1-11ea-9133-1230ab121a66.png)

5. Click "Play", and see the content from the `obs-studio` stream:

![image](https://user-images.githubusercontent.com/2212651/79851134-88408a00-83e2-11ea-949d-98bbab60a7c0.png)

#### Configuring Content in OBS Studio

**OBS Studio** can be used to add video and audio content sources to be published to `simple-streaming-server`.

![image](https://user-images.githubusercontent.com/2212651/79856956-ae6a2800-83ea-11ea-8e06-e807979bc9db.png)

- **Configuring Video**:
  - The big black box in the middle of the screen is the "canvas" for visual content.
  - One or more "Scenes" can be configured, which can be switched between when publishing
  - Zero or more "Sources" can be added to each "Scene", to 
  - Examples of "Sources" are: _static text_, _images_, _recorded videos_, _live videos_ (e.g. from a camera), _screenshares_, _window shares_.

**Configuring Audio**
  - Audio being published can be monitored in the "Mixer", both visually and audibly
  - Audio sources can be configured in Settings > Audio, and will appear in the "Mixer"
  - Examples of sources are _sound cards_, _microphones_ and _audio played by the computer_.

Here is an example of a variety of different content sources configured in **OBS Studio**:

![Screenshot from 2020-03-14 23-43-55](https://user-images.githubusercontent.com/2212651/80687655-3eddf200-8ae8-11ea-809e-235acc9d8abf.png)

## Hosted Setup

A `simple-streaming-server` can be deployed on a hosted server. For this It is assumed that this hosted server is running Linux (Ubuntu).

### `simple-streaming-server` Access Options

It is necessary to configure `simple-streaming-server` appropriately, in order to allow required remote access to the server.

#### Local publish and consume only (no remote access)

When starting `simple-streaming-server`, run the following command:
```
./livepeer \ 
        -broadcaster \
        -rtmpAddr 127.0.0.1:1935 \
        -httpAddr 127.0.0.1:8935
```
_Note: this command is technically equivalent to running the same command without `-rtmpAddr` or `-httpAddr` flags, as these are the default options. They are explicitly included here for illustrative purposes only._

`simple-streaming-server` will _only allow content to be published and consumed on the hosted server itself_:

|        | publish | consume |
|--------|:-------:|:-------:|
| local  |   yes   |   yes   |
| remote |    no   |    no   |

#### Local publish, Remote consume

When starting `simple-streaming-server`, run the following command:
```
./livepeer \ 
        -broadcaster \
        -rtmpAddr 127.0.0.1:1935 \
        -httpAddr 0.0.0.0:8935
```
This will _only allow content to be published from the hosted server itself_ but will _allow content to be consumed locally or remotely_, by any host with network access to the hosted server.

|        | publish | consume |
|--------|:-------:|:-------:|
| local  |   yes   |   yes   |
| remote |    no   |   yes   |

#### Remote publish and consume (full remote access)

When starting `simple-streaming-server`, run the following command:
```
./livepeer \ 
        -broadcaster \
        -rtmpAddr 0.0.0.0:1935 \
        -httpAddr 0.0.0.0:8935
```

This will _allow content to be published and / or consumed remotely_, by any host with network access to the hosted server.

|        | publish | consume |
|--------|:-------:|:-------:|
| local  |   yes   |   yes   |
| remote |   yes   |   yes   |

Note: when publishing or consuming content from a remote host, the server's IP address must be used instead of `127.0.0.1`
Note: you may need to open ports `1935` and `8935` in your server's firewall configuration in order to allow internet access.

## Architecture Summary

This section provides a high level summary of the logical and functional architecture of a `simple-streaming-server`.

![image](https://user-images.githubusercontent.com/2212651/80694236-d72ca480-8af1-11ea-9498-f270796af5b8.png)

Content can be published to `simple-streaming-server` via `RTMP` to port `1935`.

Content can be consumed by requesting a URL with `.m3u8` extension, via `http` from port `8935`. `simple-streaming-server` will respond by serving a sequence of content segment files with `.hs` extensions over `http`, for playback.

The code for this software is available on [Livepeer's go-livepeer repository](https://github.com/livepeer/go-livepeer).

## Transcoding

`simple-streaming-server` can be configured to transcode the source content into different frame sizes and frame rates.

Transcoding allows content to be consumed by devices with less-performant network connections (bytes per second).

### Local Transcoding

![image](https://user-images.githubusercontent.com/2212651/80705206-a8b7c500-8b03-11ea-8c51-a5892ef577fa.png)

Transcoding can be performed on the same computer / server running the `simple-streaming-server`.

1. Open a `Terminal`, and run the following command from the folder containing `livepeer` binary:
```
./livepeer \
        -broadcaster \
        -orchAddr 127.0.0.1:8936 \
        -transcodingOptions P144p30fps16x9,P240p30fps16x9 \
        -v 99
```
  - `-orchAddr` specifies the location of the Orchestrator / Transcoder service on the network
  - `-transcodingOptions` specifies frame sizes and frame rates to be transcoded into.
  - `-v 99` is the highest level of logging output.

2. Open another `Terminal`, and run the following command from the folder containing `livepeer` binary:
```
./livepeer \
        -orchestrator \
        -transcoder \
        -serviceAddr 127.0.0.1:8936 \
        -cliAddr 127.0.0.1:7936 \
        -v 99
```
  - `-orchestrator` and `-transcoder` tell the software to run in Orchestrator and Transcoder modes
  - `-serviceAddr` specifies the IP address and port that this service should run on the network
  - `-v 99` is the highest level of logging output.

**`simple-streaming-server` is now running with Local Transcoding enabled.**

3. [Inspect the content metadata](#inspect-content-metadata) to see the additional streams available for consumption:

![image](https://user-images.githubusercontent.com/2212651/80700605-9cc80500-8afb-11ea-9ef4-b041b7f39a55.png)

Note: many players of streaming content will dynamically switch between available streams in order to optimise the quality of playback given the available bandwidth.

### Local Distributed Transcoding

![Screenshot from 2020-04-30 16-58-19](https://user-images.githubusercontent.com/2212651/80705292-cf75fb80-8b03-11ea-8285-43a2a0dd7596.png)

Transcoding activities can also be distributed across an Orchestrator, and one or more Transcoders.

1. Open a `Terminal`, and run the following command from the folder containing `livepeer` binary:
```
./livepeer \
        -broadcaster \
        -orchAddr 127.0.0.1:8936 \
        -transcodingOptions P144p30fps16x9,P240p30fps16x9 \
        -v 99
```

2. Open another `Terminal`, and run the following command from the folder containing `livepeer` binary:
```
./livepeer \
        -orchestrator \
        -orchSecret pineapple \
        -serviceAddr 127.0.0.1:8936 \
        -cliAddr 127.0.0.1:7936 \
        -v 99
```
  - `-orchSecret` is a way for this Orchestrator to allow Transcoders to authenticate

3. Open another `Terminal`, and run the following command from the folder containing `livepeer` binary:
```
./livepeer \
        -transcoder \
        -orchSecret pineapple \
        -orchAddr 127.0.0.1:8936 \
        -v 99
```

**`simple-streaming-server` is now running with (Local) Distributed Transcoding enabled.**

### Remote Transcoding

Transcoding can also be performed on a different computer / server from the `simple-streaming-server`.

For this you will need two hosts (computers / servers):

- For the `simple-streaming-server`
  - This host will need to be able to connect to port `8936` on the host of the remote transcoder.
- For the remote transcoder

1. Open a `Terminal` on the remote transcoder host, and run the following command:
```
./livepeer \
        -broadcaster \
        -orchAddr 192.168.2.113:8936 \
        -transcodingOptions P144p30fps16x9,P240p30fps16x9 \
        -v 99
```
  - `192.168.2.113` is the IP address of the remote transcoder host

2. Open a `Terminal` on the `simple-streaming-server` host, and run the following command:
```
./livepeer \
        -orchestrator \
        -transcoder \
        -serviceAddr 192.168.2.113:8936 \
        -cliAddr 127.0.0.1:7936 \
        -v 99
```
  - `192.168.2.113` is the IP address of the remote transcoder host

**`simple-streaming-server` is now running with Remote Transcoding enabled.**

### Outsourced Transcoding (requires payment in Ethereum)

Transcoding services can be purchased directly from Orchestrators operating in Livepeer's public Transcoding Marketplace.

Services can be paid for on a pay-as-you-go basis using Ethereum, without any minimum contractual obligation.

1. Install `geth`, which is [client software to run Ethereum, released by Ethereum Foundation](https://geth.ethereum.org/docs/install-and-build/installing-geth).

- This client software can be used to sync Ethereum blockchain, and to broadcast transactions to be included in the blockchain.

2. Open a `Terminal` and run the following command to run `geth` client
```
geth -rpc -rpcapi eth,net,web3 --syncmode "light"
```

3. Wait until `geth` has imported all new block headers, and has started downloading 1 block at a time:

![image](https://user-images.githubusercontent.com/2212651/80710566-968e5480-8b0c-11ea-81b8-f0efd19fa875.png)

4. Open another `Terminal` and run the following command:
```
./livepeer \
        -broadcaster \
        -network mainnet \
        -transcodingOptions P144p30fps16x9,P240p30fps16x9 \
        -ethUrl http://127.0.0.1:8545 \
        -pixelsPerUnit 1 \
        -maxPricePerUnit 1 \
        -v 99
```
  - `mainnet` signifies Ethereum's main network
  - `-ethUrl` is the network location of the `geth` service.
  - `-pixelsPerUnit` and `-maxPricePerUnit` are for setting the maximum price to be paid for Transcoding

5. Enter a Passphrase twice:

![image](https://user-images.githubusercontent.com/2212651/80711420-f20d1200-8b0d-11ea-9f30-c33c4f80de06.png)

Note: no characters will appear in the window when typing the passphrase.

The Passphrase will be used to encrypt the Private Key generated by this process. The Private Key will be used to sign transactions for publishing on Ethereum.

6. Enter the Passphrase again to start the `simple-streaming-server`.

7. Wait until the text `CLI server listening on 127.0.0.1:7935` is displayed in the console:

![image](https://user-images.githubusercontent.com/2212651/80712819-24b80a00-8b10-11ea-987f-6cee6a29bc52.png)

8. Open a `Terminal`, and run the following command from the folder containing `livepeer_cli` binary:
```
./livepeer_cli
```

9. Send some ETH from your wallet to the `ETH Account` listed under `NODE STATS`.

10. In `livepeer_cli`, run option `12. Invoke "deposit broadcasting funds" (ETH)`

![image](https://user-images.githubusercontent.com/2212651/80714073-081cd180-8b12-11ea-8fc4-070282141905.png)

This command will deposit some ETH into a smart contract in Livepeer's protocol, which can be spent on Transcoding services.

11. Enter the amount of ETH you would like to deposit into the contract.

12. Enter the amount of ETH you would like to keep in reserve in the contract.

**`simple-streaming-server` is now running with Outsourced Transcoding on Livepeer, with payment on Ethereum.**

Further details on setting the maximum price to be paid for Transcoding can be found in [Livepeer's Broadcaster documentation](https://livepeer.readthedocs.io/en/latest/broadcasting.html).

To find out more about Livepeer, go to this [10-minute primer](https://livepeer.org/primer/).

## Start on system boot

This section explains how to configure `simple-streaming-server` to start when the underlying system starts.

The instructions use `systemd` on Linux (Ubuntu), and require root / `sudo` access. 

### `simple-streaming-server.service`

0. Ensure the `simple-streaming-server` has been [downloaded and installed on the underlying system](#minimum-setup)

1. Run the following commands to fetch a `simple-streaming-server.service` file from `/etc/systemd/system` folder
```
cd /etc/systemd/system
sudo wget https://raw.githubusercontent.com/videoDAC/simple-streaming-server/master/systemd/simple-streaming-server.service
```

2. Run the following commands to enable and start `simple-streaming-server.service`:
```
sudo systemctl enable simple-streaming-server.service
sudo systemctl start simple-streaming-server.service
```

**`simple-streaming-server` is now running.**

3. Run the following command to tail the logs:
```
sudo journalctl -f --unit=simple-streaming-server.service
```

### `publish-test-source.service`

0. Ensure the `FFmpeg` has been [downloaded and installed on the underlying system](#minimum-setup)

1. Run the following commands to fetch a `publish-test-source.service` file from `/etc/systemd/system` folder
```
cd /etc/systemd/system
sudo wget https://raw.githubusercontent.com/videoDAC/simple-streaming-server/master/systemd/publish-test-source.service
```

2. Run the following commands to enable and start `simple-streaming-server.service`:
```
sudo systemctl enable publish-test-source.service
sudo systemctl start publish-test-source.service
```

**`simple-streaming-server` is now running with a test source being published into it.**

3. Run the following command to tail the logs:
```
sudo journalctl -f --unit=publish-test-source.service
```

4. Run `curl http://0.0.0.0:8935/stream/hello_world.m3u8` to see
```
#EXTM3U
#EXT-X-VERSION:3
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=4000000,RESOLUTION=1000x1000
hello_world/source.m3u8
```

### `local-transcoding.service`

0. Ensure the `simple-streaming-server` has been [downloaded and installed on the underlying system](#minimum-setup)

1. Run the following commands to fetch a `simple-streaming-server.service` file from `/etc/systemd/system` folder
```
cd /etc/systemd/system
sudo wget https://raw.githubusercontent.com/videoDAC/simple-streaming-server/master/systemd/local-transcoding.service
```

2. Run the following commands to enable and start `local-transcoding.service`:
```
sudo systemctl enable local-transcoding.service
sudo systemctl start local-transcoding.service
```

**`simple-streaming-server` is now running with local transcoding service.**

3. Run the following command to tail the logs:
```
sudo journalctl -f --unit=local-transcoding.service
```

4. Ensure `publish-test-source.service` is running, then run `curl http://0.0.0.0:8935/stream/hello_world.m3u8` to see
```
#EXTM3U
#EXT-X-VERSION:3
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=4000000,RESOLUTION=1000x1000
hello_world/source.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=400000,RESOLUTION=256x144
hello_world/P144p30fps16x9.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=0,BANDWIDTH=600000,RESOLUTION=426x240
hello_world/P240p30fps16x9.m3u8
```

## Roadmap

This section describes additional features to be defined as part of this guide.

### HTTPS Content Serving

This section will describe how to configure `simple-streaming-server` to serve content as `https` instead of `http`.

This is necessary for content to be served to webpages which themselves are served via `https`.

- Install `nginx`
- Configure `nginx`
- Generate and install a cert
- Test the installation

### Web Player

This section will describe how to deploy a web-based streaming content player.

It will describe the code to be embedded into a webpage.

It will also describe how to deploy a webpage hosted on [IPFS](https://ipfs.io), with name resolution using [ENS](https://ens.domains). An example of such a page is http://criticaltv.videodac.eth.link

### Server-side Paywall

This section will describe how to install and configure [Orchid](https://www.orchid.com/)'s open-source software to prevent `simple-streaming-server` from serving content unless the consumer is paying for the content in [OXT](https://coinmarketcap.com/currencies/orchid/).

![image](https://user-images.githubusercontent.com/2212651/80733192-001d5b80-8b2b-11ea-8a57-f4877340bfe5.png)

### GPU Transcoding

This section will describe how to configure the `-transcoder` process to use a GPU for Transcoding.

### Content Distribution Network

This section will describe how to configure a commercial Content Distribution Network (CDN), such as Amazon CloudFront, Cloudflare or Akamai. This is required in order to be able to serve content to large numbers of viewers simultaneously.

### IP Address Whitelisting

This section will explain how to configure `simple-streaming-server` to only allow publishing and consuming from specific whitelisted IP addresses.

### Raspberry Pi

