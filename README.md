# `simple-streaming-server`

`simple-streaming-server` is a simple server-based platform for streaming content.

It uses Livepeer's open-source software, and does not require any cryptocurrency.

## What does it do?

A `simple-streaming-server` can **receive** and **serve** streaming content.

It can **receive** streaming content published from tools like [OBS Studio](https://obsproject.com/), [ManyCam](https://manycam.com/) or [FFmpeg](https://www.ffmpeg.org/), in `RTMP` format.

It can **serve** streaming content over `http` with a `.m3u8` extension for playback in tools like [VLC Media Player](https://www.videolan.org/vlc/index.html), media-enabled Mobile browsers (Brave, Firefox or Chrome), embedded in an `html` page using a stream player such as `hls.js`, or in your own mobile application.

![image](https://user-images.githubusercontent.com/2212651/79846142-afe02400-83db-11ea-8cb0-01fb21fdbeb1.png)

## Minimum Setup - Local Computer

Here are instructions to setup a `simple-streaming-server` on your local computer.

It will work on Mac or Linux (Ubuntu).

1. Download the latest software build from [Livepeer's Release Page](https://github.com/livepeer/go-livepeer/releases).

- If you use a Mac, download the `livepeer-darwin-amd64.tar.gz` file

- If you use Linux (Ubuntu), download the `livepeer-linux-amd64.tar.gz` file

![image](https://user-images.githubusercontent.com/2212651/79833859-b82f6380-83c9-11ea-9a78-e8eb1599218d.png)

2. Unzip the software using your operating system's zipping / unzipping software:

- On Mac, 

- On Linux (Ubuntu), simply open the `livepeer-darwin-amd64.tar.gz` file then click "Extract", and extract it to "Home".

3. Open `Terminal`, and run the following:

- On Mac, 

- On Linux (Ubuntu), run `./livepeer-linux-amd64/livepeer -broadcaster`

When you see the line `Video Ingest Endpoint - rtmp://127.0.0.1:1935`, your simple-streaming-server is running.

## Next Steps

Now that the `simple-streaming-server` is running, you can decide what to do next:

- Publish Streaming Content to the `simple-streaming-server`

- Playback Streaming Content from the `simple-streaming-server`

- Learn more about how the `simple-streaming-server` works

- Customise the code used in `simple-streaming-server`

- Create a hosted `simple-streaming-server`

## Publish Streaming Content

There are many ways you can publish streaming content to your `simple-streaming-server`.

![image](https://user-images.githubusercontent.com/2212651/79847772-d010e280-83dd-11ea-84dc-63b9c461e87a.png)

Here are a few options.

### From the command line

You can use `FFmpeg` to generate a livestream showing a test card.

0. Make sure your `simple-streaming-server` is running.

1. Download and install [`FFmpeg`](https://www.ffmpeg.org/).

2. Run the following command:
```
ffmpeg -re -f lavfi -i testsrc=size=500x500:rate=30,format=yuv420p \
       -f lavfi -i sine -c:v libx264 -b:v 10000k \
       -x264-params keyint=30 -c:a aac -f flv \
       rtmp://127.0.0.1:1935/testcard
```

3. See that the `simple-streaming-server` is receiving a stream called `testcard`.

![image](https://user-images.githubusercontent.com/2212651/79846846-8d023f80-83dc-11ea-87f7-9232922abdb7.png)

### From a graphical user interface (OBS Studio)

You can use **OBS Studio** to configure your livestream however you like with a drag-and-drop interface.

0. Make sure your `simple-streaming-server` is running.

1. Download and install [OBS Studio](https://obsproject.com/)

2. Launch OBS Studio, and cancel the auto-configuration wizard.

3. Go to Settings > Output

4. Set "Output Mode" to "Advanced".

5. Set the Streaming Keyframe interval to `2` seconds.

![image](https://user-images.githubusercontent.com/2212651/79845125-398ef200-83da-11ea-911f-709778a75610.png)

6. Go to Settings >  Stream

7. Set "Service" to `Custom`

8. Set "Server" to `rtmp://127.0.0.1`

9. Set "Stream Key" to `obs-studio`

![image](https://user-images.githubusercontent.com/2212651/79847130-eb2f2280-83dc-11ea-86f9-de27a4d3686d.png)

10. Click OK from "Settings".

11. Click "Start Streaming"

12. See that the `simple-streaming-server` is receiving a stream called `obs-studio`.

![image](https://user-images.githubusercontent.com/2212651/79847289-25002900-83dd-11ea-8493-86f22e0dff56.png)

#### Configuring Content in OBS

**Configuring Video**: The big black box in the middle of the screen it your "canvas" for visual content.

You can have 1 or more "Scenes", and on each scene you can add 1 or more "Sources", e.g. video from a webcam.

**Configuring Audio**: The "Mixer" is where you configure the sound for your livestream.

You can configure new sound devices in Settings > Audio, including microphones, sound cards and sounds being played by your computer.

## Playback Streaming Content

There are many ways you can playback streaming content from your `simple-streaming-server`.

![image](https://user-images.githubusercontent.com/2212651/79847817-e28b1c00-83dd-11ea-964d-792a331cbf9c.png)

Here are a few options.

### From the command line

You can use `FFmpeg` to generate a livestream showing a test card.

1. Download and install [`FFmpeg`](https://www.ffmpeg.org/).

2. Run `ffmpeg -re -f lavfi -i testsrc=size=500x500:rate=30,format=yuv420p -f lavfi -i sine -c:v libx264 -b:v 10000k -x264-params keyint=30 -c:a aac -f flv rtmp://127.0.0.1:1935/testcard`

### From a graphical user interface

You can use `FFmpeg` to generate a livestream showing a test card.


## Platform Overview

Video content to be published to, and requested from `simple-streaming-server`

![image](https://user-images.githubusercontent.com/2212651/79838698-0300a980-83d1-11ea-8ea8-b3d3022e065b.png)

Content can be streamed to `rtmp://127.0.0.1:1935/streamID`.

Content can be requested from `http://127.0.0.1:8935/stream/streamID`.


## Hosted Setup

The most 
