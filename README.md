# `simple-streaming-server`

`simple-streaming-server` is an application for streaming content, running on a computer.

The streaming content must be Video + Audio, and can be either live streaming content (e.g. from camera and microphone), or pre-recorded streaming content (e.g. from a file on disk).

It uses Livepeer's open-source software, and does not cost any cryptocurrency or require any awareness of blockchain.

## What does it do?

A `simple-streaming-server` can **receive** and **serve** streaming content.

![image](https://user-images.githubusercontent.com/2212651/80460726-dd841a80-8951-11ea-9556-391153100058.png)

It can **receive** streaming content published in `RTMP` format, from tools like [OBS Studio](https://obsproject.com/), [ManyCam](https://manycam.com/), [FFmpeg](https://www.ffmpeg.org/), or many other tools.

It can **serve** streaming content over `http` with a `.m3u8` extension, for playback in tools like [VLC Media Player](https://www.videolan.org/vlc/index.html), media-enabled Mobile browsers (Brave, Firefox or Chrome), embedded in an `html` page using a stream player such as `hls.js`, or in your own mobile application.

## Minimum Setup - Local Computer

Here are instructions to setup a `simple-streaming-server` on your local computer.

It will work on Mac or Linux (Ubuntu).

1. Download the latest software build from [Livepeer's Release Page](https://github.com/livepeer/go-livepeer/releases), under where it says `Assets`:

- If you use a Mac, download the `livepeer-darwin-amd64.tar.gz` file to your _Downloads_ folder

- If you use Linux (Ubuntu), download the `livepeer-linux-amd64.tar.gz` file

2. Unzip the file:

- On Mac, simply open the file, and it will extract to the folder containing the file (_Downloads_).

- On Linux (Ubuntu), simply open the `livepeer-darwin-amd64.tar.gz` file then click "Extract", and extract it to "Home".

3. Open `Terminal`, and run the following:

- On Mac, run `./Downloads/livepeer-darwin-amd64/livepeer -broadcaster`

- On Linux (Ubuntu), run `./livepeer-linux-amd64/livepeer -broadcaster`

**`simple-streaming-server` will be running** when you see the line `Video Ingest Endpoint - rtmp://127.0.0.1:1935`

![image](https://user-images.githubusercontent.com/2212651/79856413-f177cb80-83e9-11ea-8ece-ac1f9c143f08.png)

Note: please note that a `simple-streaming-server` currently works best when deployed to a dedicated hosted server. This allows you to publish and serve content to and from it at all times. If you would to [create a hosted instance of `simple-streaming-server`](#hosted-setup).

# Next Steps

Now that the `simple-streaming-server` is running, you can decide what to do next:

- [Publish Streaming Content](#publish-streaming-content) to the `simple-streaming-server`

- [Playback Streaming Content](#playback-streaming-content) from the `simple-streaming-server`

- [Create a hosted instance](#hosted-setup) of `simple-streaming-server`

- Learn more about how the `simple-streaming-server` works in the [Platform Overview](#platform-overview)

- Add [Transcoding](#transcoding) to make content served by your `simple-streaming-server` more accessible to all

- [Customise the code](#customise-the-code) used in `simple-streaming-server`

## Publish Streaming Content

There are many ways you can publish streaming content to your `simple-streaming-server`.

![image](https://user-images.githubusercontent.com/2212651/80461006-4075b180-8952-11ea-9507-85db1a00d071.png)

Here are a few options for publishing from a **command line interface**, or from a **graphical user interface**.

### From the command line

You can use `FFmpeg` to generate a livestream showing a test card.

0. Make sure your `simple-streaming-server` is running.

1. Download and install [`FFmpeg`](https://www.ffmpeg.org/).

2. Run the following command:
```
ffmpeg -re -f lavfi -i \
        testsrc=size=500x500:rate=30,format=yuv420p \
       -f lavfi -i sine -c:v libx264 -b:v 10000k \
       -x264-params keyint=30 -c:a aac -f flv \
       rtmp://127.0.0.1:1935/testcard
```

3. See that the `simple-streaming-server` is receiving a stream called `testcard`.

![image](https://user-images.githubusercontent.com/2212651/79846846-8d023f80-83dc-11ea-87f7-9232922abdb7.png)

### From a graphical user interface

You can use **OBS Studio** to configure your livestream however you like with a simple-but-powerful drag-and-drop interface.

1. Download and install [OBS Studio](https://obsproject.com/)

2. Launch OBS Studio, and cancel the auto-configuration wizard.

![image](https://user-images.githubusercontent.com/2212651/79856956-ae6a2800-83ea-11ea-8e06-e807979bc9db.png)

3. Go to Settings > Output

4. Set "Output Mode" to "Advanced".

5. Set the Streaming Keyframe interval to `2` seconds.

![image](https://user-images.githubusercontent.com/2212651/79845125-398ef200-83da-11ea-911f-709778a75610.png)

6. Go to Settings >  Stream

7. Set "Service" to `Custom`

8. Set "Server" to `rtmp://127.0.0.1`

9. Set "Stream Key" to `obs-studio`

![image](https://user-images.githubusercontent.com/2212651/79847130-eb2f2280-83dc-11ea-86f9-de27a4d3686d.png)

10. Click OK to close "Settings".

11. Under "Sources", click the `+`

12. Add a "Text" source, and write some text

![image](https://user-images.githubusercontent.com/2212651/79850922-3861c300-83e2-11ea-973c-e9ab1f9a49c1.png)

13. Make sure your `simple-streaming-server` is running.

14. Click "Start Streaming" (and also "Start Recording" if you also want to record the stream)

15. See that the `simple-streaming-server` is receiving a stream called `obs-studio`.

![image](https://user-images.githubusercontent.com/2212651/79847289-25002900-83dd-11ea-8493-86f22e0dff56.png)

#### Configuring Content in OBS

**Configuring Video**: The big black box in the middle of the screen it your "canvas" for visual content.

You can have 1 or more "Scenes", and on each scene you can add 1 or more "Sources".

"Sources" can be text, image, recorded video, live video (from camera), screenshare, window share.

**Configuring Audio**: The "Mixer" is where you configure the sound for your livestream.

You can configure new sound devices in Settings > Audio, including microphones, sound cards and sounds being played by your computer.

## Playback Streaming Content

There are many ways you can playback streaming content from your `simple-streaming-server`.

![image](https://user-images.githubusercontent.com/2212651/80461163-7dda3f00-8952-11ea-8f64-5b1c0c38c279.png)

Here are a few options for publishing from a **command line interface**, or from a **graphical user interface**.

### From the command line

You can use `ffplay` as part of `FFmpeg` to playback a stream.

1. Download and install [`FFmpeg`](https://www.ffmpeg.org/).

2. Publish a `testcard` stream using `FFmpeg` (see above).

3. Run `ffplay http://127.0.0.1:8935/stream/testcard.m3u8`

4. See the content from the `testcard` stream:

![image](https://user-images.githubusercontent.com/2212651/79850180-2af80900-83e1-11ea-86ea-2d97ea83d5ef.png)

### From a graphical user interface

You can use **VLC Media Player** to playback a Network Stream.

0. Publish a `obs-studio` stream using **OBS Studio** (see above).

1. Download and install [VLC Media Player](https://www.videolan.org/vlc/index.html)

2. Launch VLC Media Player

3. Select Media > Open Network Stream... (Ctrl-N)

4. Enter `http://127.0.0.1:8935/stream/obs-studio.m3u8` as the network URL

![image](https://user-images.githubusercontent.com/2212651/79850448-93df8100-83e1-11ea-9133-1230ab121a66.png)

5. Click "Play", and see the content from the `obs-studio` stream:

![image](https://user-images.githubusercontent.com/2212651/79851134-88408a00-83e2-11ea-949d-98bbab60a7c0.png)

## Hosted Setup

A `simple-streaming-server` is likely best deployed on a dedicated server, such as a hosted Virtual Private Server (VPS).

The instructions are largely similar as a local setup - with the only difference that you need to have ports 1935 and 8935 open.

You will also need to configure your publishing and playback to reference the dedicated server's IP address, instead of 127.0.0.1, which is the address of your local computer.

## Platform Overview

Video content to be published to, and requested from `simple-streaming-server`

![image](https://user-images.githubusercontent.com/2212651/79838698-0300a980-83d1-11ea-8ea8-b3d3022e065b.png)

Content can be streamed to `rtmp://127.0.0.1:1935/streamID` to publish.

Content can be requested from `http://127.0.0.1:8935/stream/streamID` for playback.

## Transcoding

Your `simple-streaming-server` currently is able to serve content in the "source" format that it was published in. That is to say, that if you stream in e.g. `1920x1080` (Full HD), then the consumer will only be able to watch in `1920x1080`.

Livepeer's software also allows you to maximise the accessibility of streaming content. It does this by Transcoding, or "shrinking" the content into "lighter" formats.

These "lighter" formats have the following advantages for consumers of A/V content:

- __Faster load time__ - the stream starts straight away, because less data is required (up to 900x less)
- __Works on slower internet connections__ - due to less data required to be received (e.g. can work on 2G, 3G, 3.5G)
- __Works on older devices__ - as it requires less power to play back content (e.g. on old smartphones)

To include Transcoding, see [videoDAC's Streaming Back-End repository](https://github.com/videoDAC/streaming-back-end).

![image](https://user-images.githubusercontent.com/59374467/78892333-d40c3e80-7a86-11ea-8823-5b90dc9055e1.png)

## Customise the code

`simple-streaming-server` uses software from [Livepeer](https://github.com/livepeer) project.

Livepeer is an open-source project and accepts contributions in the form of Pull Requests and Issues.

You can talk to other members of the community on [Livepeer Community Discord channel](https://discord.gg/RR4kFAh).
