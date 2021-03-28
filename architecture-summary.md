## Architecture Summary

This section provides a high level summary of the logical and functional architecture of a Livepeer Broadcaster.

![image](https://user-images.githubusercontent.com/2212651/112746920-d33e2680-8fcf-11eb-924b-e4bb648f8c77.png)

Content can be published to Livepeer Broadcaster via `RTMP` to port `1935`.

Content can be consumed by requesting a URL with `.m3u8` extension, via `http` from port `8935`.

Livepeer Broadcaster will respond by serving a sequence of content segment files with `.hs` extensions over `http`, for playback.

The code for this software is available on [Livepeer's go-livepeer repository](https://github.com/livepeer/go-livepeer).

[Return to main page](./README.md#next-steps)
