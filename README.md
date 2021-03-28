# Livepeer Broadcaster

## Introduction

This page gives an introduction to Livepeer Broadcaster.

The main objective is to help you install and operate a Broadcaster on a computer, and to learn how to interact with it.

## Overview

Livepeer Broadcaster is software to run on a computer or a server. It uses entirely open-source and freely available software.

A Livepeer Broadcaster can **receive** and **serve** streaming content. It can also be configured to transcode streaming content to improve accessibility of content.

The streaming content must be Video + Audio, and must be published into the Broadcaster in a linear stream. Content can be live (from camera and microphone) and / or recorded (from a disk).

![image](https://user-images.githubusercontent.com/2212651/112745744-4479db80-8fc8-11eb-9ace-0c77ee9bf438.png)

It can **receive** streaming content published in `RTMP` format, from tools like [OBS Studio](https://obsproject.com/), [ManyCam](https://manycam.com/), [FFmpeg](https://www.ffmpeg.org/), or many other `rtmp` software libraries and tools.

It can **serve** streaming content over `http` with a `.m3u8` extension, for playback in tools like [VLC Media Player](https://www.videolan.org/vlc/index.html), media-enabled Mobile browsers (Brave, Firefox or Chrome), embedded in an `html` page using a stream player such as `hls.js`, or inside a mobile application using something like [ExoPlayer](https://exoplayer.dev/).

## Minimum Setup

Here are instructions to setup a Livepeer Broadcaster on a local computer. They will work on Mac or Linux (Ubuntu). 

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

**Livepeer Broadcaster is now running.**

![image](https://user-images.githubusercontent.com/2212651/79856413-f177cb80-83e9-11ea-8ece-ac1f9c143f08.png)

# Next Steps

Now that Livepeer Broadcaster is running, here are some further things you can do:

- [Publish to, and Consume from a Livepeer Broadcaster](./publish-and-consume-content.md)

- [Learn more about how Livepeer Broadcaster works](./architecture-summary.md)

- [Add Transcoding to increase accessibility of streaming content](./transcoding.md)

- [Build a hosted instance of Livepeer Broadcaster](./hosted-setup.md)

- [Configure Livepeer Broadcaster to start on system boot](./start-on-system-boot.md)

- [Build from source code](https://github.com/livepeer/go-livepeer/blob/master/doc/install.md)
