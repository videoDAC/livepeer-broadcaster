# Summary

`MINUTE LIVESTREAM` is a video tribute to the `go-livepeer` client software. The piece shows a rare perspective of a _livestream_, as it is processed by `go-livepeer`, running on a laptop computer graphical user interface.

# Unlockable Content

The unlockable content is an IPFS CID for a folder containing the `source.mp4` video file in `1080p` format, **PLUS ADDITIONAL BONUS CONTENT** of smaller "transcoded" versions of the video in `720p`, `576p`, `360p`, `240p` and `144p` formats.

# Overview

When receiving an rtmp livestream, `go-livepeer`'s segmenter process writes a sequence of `.ts` files to local disk. These files each represent a short _segment_ of audio-visual content, and combine to form a `hls` video stream.

Each segment is approximately two seconds long, and exists for around 10 seconds, before being garbage collected.

`hls` is "HTTP Live Streaming", and the stream is served as a `.m3u8` manifest file.

The work depicts these `.ts` files throughout the duration of a one-minute-long broadcast.

Audio was produced and added in post-production.

# Action Timeline

`00:00` video starts

`00:00` title sequence starts

`.....`

`00:06` desktop interface appears, showing OBS Studio and File Browser windows

`00:08` the "Start Streaming" button is pressed in OBS Studio

`.....`

`00:16` the first `.ts` segment appears: `2198ccb3_0.ts`

`00:16` the `hls` playlist manifest appears: `2198ccb3.m3u8`

`00:18` the second `.ts` segment appears: `2198ccb3_1.ts`

`.....`

`00:26` the sixth `.ts` segment appears: `2198ccb3_5.ts`

`-----`

`00:28` the seventh `.ts` segment appears: `2198ccb3_6.ts`

`00:28` the first `.ts` segment disappears: `2198ccb3_0.ts`

`-----`

`00:30` the eighth `.ts` segment appears: `2198ccb3_7.ts`

`00:30` the second `.ts` segment disappears: `2198ccb3_1.ts`

`.....`

`01:08` the "Stop Streaming" button is pressed in OBS Studio

`01:10` all `.ts` segments and `.m3u8` manifest disappear

`01:12` closing sequence starts

`01:18` video ends.

# Notes

The artist makes heavy use of iconography when creating the video.

Use of **Ubuntu** as the desktop operating system, and **OBS Studio** for video production represent Open Source Software, and the launcher icons for **Brave Browser** and **IPFS Desktop** represent web3.

The presence of a **Home** icon connects with eth2's incentives for run internet infrastructure in our Homes, instead of in power-hungry and centralised data centres and mining farms.

The artist shows the folder name **mainnet**, to depict that the software is connected to an eth1 mainnet RPC endpoint.Further, highlighting the **keystore** folder (containing 1 item), raises the viewer's awareness the geth-generated signing-key present in `go-livepeer`. These two specific depictions highlight the opportunities for easier integration of `go-livepeer` with any EVM-compatible blockchain or dapp.

The video duration is **64 seconds**, where the number `64` is a power of 2, to acknowledge the binary system, which computers are built on.

The livestream duration of **1 minute** was chosen to be easily communicable and easily-digestible.

The depiction of the **lpdb.sqlite3 file** represents Livepeer's investment in development of light-clients. Light-clients do not require access to all onchain data, so can run on lower powered devices such as smartphones and Raspberry Pis. The file is storage for a local database, containing cached information from `go-livepeer`, as well as mainnet chainstate data.

The segment files each have **2198ccb3** included in their file name. This "manifest id" is randomly generated, and is shown to acknowledge the importance of random numbers in modern cryptography.

The **ukulele** and **guitar** within the background picture represent the opportunity for music and public blockchains to form future synergies.

The video was recorded in landscape format, designed for playback on televisions, laptops, desktop monitors and mobile phones / tablets (held in _landscape_ orientation).

The title **MINUTE LIVESTREAM** is inspired by Frédéric Chopin's `Waltz in D-flat major, Op. 64, No. 1` (so-called Minute Waltz).

To conclude, the artist lists **a proposed 3-step approach to enhancing the functionality of `go-livepeer`**, as a "hidden-in-plain-sight" addition to the File Browser window.

# Technical Specifications

## File

Type: `MPEG-4 video (video/mp4)`
Name: `source.mp4`
Size: `36,908,998 bytes`
sha256sum: `1e2ab5800209daafad4b2c033b2ebf8f9da686afafbbc31c8ab863340a2b7706`

## Video

Dimensions: `1920 x 1080`
Duration: `00:01:08`
Codec: `H.264 (High Profile)`
Frame Rate: `29.97 fps`
Bit Rate: `3654 kbps`

## Audio

Codec: `MPEG-4 AAC`
Channels: `Stereo`
Sample Rate: `44100 Hz`
Bit Rate: `110 kbps`

## Production Environment

Video Production Software: `OBS Studio 26.1.1`, `FFmpeg`, `go-livepeer`, `Terminal`
Operating System: `Ubuntu 20.04.2 LTS`
Hardware: `Lenovo Thinkpad T490s` with `Samsung 970 EVO Plus 1TB PCIe NVMe M.2`

# Livepeer

Livepeer's public mainnet performs live Adaptive Bitrate Video Transcoding for broadcasters.

This is an important, hard-to-scale, compute-heavy task that developers of video streaming platforms need in order to ensure their streams can reach _every user_ regardless of device type or connection speed.

# Acknowledgements

Producer: `chrishobcroft.eth`
Audio: `matlemad.eth`

Thanks to `nico.eth` and @dob for wording contributions.
