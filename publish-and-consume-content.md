## Publish and Consume Content

This section explains how to publish and consume content to and from Livepeer Broadcaster.

This can be done via a [command line interface](#command-line-interface) using `FFmpeg`, or from a [graphical user interface](#graphical-user-interface) using **OBS Studio** and **VLC Media Player**.

[Return to main page](./README.md#next-steps)

### Command Line Interface

This section explains how to publish and consume content to and from Livepeer Broadcaster using a command line interface (CLI).

#### Install `FFmpeg`

You can test publishing content into a Livepeer Broadcaster using `ffmpeg`.

Install `FFmpeg` on Linux (Ubuntu) using `sudo apt install ffmpeg`

Install `FFmpeg` on a Mac using instructions on [FFmpeg's website](https://www.ffmpeg.org/download.html#build-mac).

#### Publish a test source

`FFmpeg` can be used to generate and publish a test source of content to Livepeer Broadcaster:

0. Make sure Livepeer Broadcaster is running on localhost `127.0.0.1`.

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
  
2. See that Livepeer Broadcaster is receiving a stream called `test_source`.

![image](https://user-images.githubusercontent.com/2212651/80678235-2a91f900-8ad8-11ea-801e-fd2724eb5b43.png)

3. Look in `~/.lpData/offchain` folder to see the segments of video which make up the livestream.

![image](https://user-images.githubusercontent.com/2212651/112746828-24014f80-8fcf-11eb-997d-7fa956a74950.png)

[Return to main page](./README.md#next-steps)

#### Publish a recorded video

`FFmpeg` can be used to publish recorded content to Livepeer Broadcaster:

0. Make sure Livepeer Broadcaster is running on localhost `127.0.0.1`.

1. Run the following command:
```
ffmpeg \
        -re \
        -i video.mov \
        -codec copy \
        -f flv rtmp://127.0.0.1:1935/recorded_content
```
  - `recorded_content` is the "stream key" for this publication.
  
2. See that Livepeer Broadcaster is receiving a stream called `recorded_content`.

![image](https://user-images.githubusercontent.com/2212651/80683054-3209d000-8ae1-11ea-9d3f-edd4d22be918.png)

[Return to main page](./README.md#next-steps)

#### Consume content using ffplay

`ffplay` is part of `FFmpeg`, and can be used to request and playback content from Livepeer Broadcaster.

0. Make sure content is being published into Livepeer Broadcaster.

1. Run `ffplay http://127.0.0.1:8935/stream/test_source.m3u8`

  - `test_source` is the "stream key" used when publishing content to Livepeer Broadcaster.

2. See the content from the `test_source` stream being played back:

![image](https://user-images.githubusercontent.com/2212651/79850180-2af80900-83e1-11ea-86ea-2d97ea83d5ef.png)

[Return to main page](./README.md#next-steps)

#### Inspect content metadata

`curl` is command line tool and library for transferring data with URLs, and can be used to inspect metadata of content published by Livepeer Broadcaster.

0. Make sure content is being published into Livepeer Broadcaster.

1. Run `curl http://127.0.0.1:8935/stream/test_source.m3u8`

  - `test_source` is the "stream key" used when publishing content to Livepeer Broadcaster.

2. View metadata about the stream(s) of content available for consumption, with `.m3u8` extension(s):

![image](https://user-images.githubusercontent.com/2212651/80692866-db57c280-8aef-11ea-9f68-05659ad3c7c6.png)

3. Run `curl http://127.0.0.1:8935/stream/test_source/source.m3u8`

4. View metadata about the segment(s) of content available for consumption, with `.ts` extension(s):

![image](https://user-images.githubusercontent.com/2212651/80693355-810b3180-8af0-11ea-9c98-a23e73070d77.png)

5. Run `curl http://127.0.0.1:7935/status`

6. View metadata about the status of the Livepeer Broadcaster, including details of stream(s) being served

![image](https://user-images.githubusercontent.com/2212651/112746370-eb13ab80-8fcb-11eb-8062-40d5d0b0a48a.png)

[Return to main page](./README.md#next-steps)

### Graphical User Interface

This section explains how to [publish content to](#publish-content-using-obs-studio) and [consume content from](#consume-content-using-vlc-media-player) Livepeer Broadcaster using graphical user interfaces (GUIs).

#### Publish content using OBS Studio

**OBS Studio** can be used to configure and publish streaming content to Livepeer Broadcaster:

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

12. Make sure Livepeer Broadcaster is running.

13. Click "Start Streaming" (and also "Start Recording" if you also want to record the stream).

14. See that Livepeer Broadcaster is receiving a stream called `obs-studio`.

![image](https://user-images.githubusercontent.com/2212651/79847289-25002900-83dd-11ea-8493-86f22e0dff56.png)

[Learn about what other sources of content can be configured](#configuring-content-in-obs-studio).

[Return to main page](./README.md#next-steps)

#### Consume content using VLC Media Player

**VLC Media Player** can be used to request and playback content from Livepeer Broadcaster.

0. Make sure content is being published into Livepeer Broadcaster.

1. Download and install [VLC Media Player](https://www.videolan.org/vlc/index.html)

2. Launch VLC Media Player

3. Select Media > Open Network Stream... (Ctrl-N)

4. Enter `http://127.0.0.1:8935/stream/obs-studio.m3u8` as the network URL

![image](https://user-images.githubusercontent.com/2212651/79850448-93df8100-83e1-11ea-9133-1230ab121a66.png)

5. Click "Play", and see the content from the `obs-studio` stream:

![image](https://user-images.githubusercontent.com/2212651/79851134-88408a00-83e2-11ea-949d-98bbab60a7c0.png)

[Return to main page](./README.md#next-steps)

#### Configuring Content in OBS Studio

**OBS Studio** can be used to add video and audio content sources to be published to Livepeer Broadcaster.

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

[Return to main page](./README.md#next-steps)
