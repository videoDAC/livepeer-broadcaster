Contents:

- [Transcoding Overview](#transcoding-overview)
- [Local Transcoding](#local-transcoding)
- [Local Distributed Transcoding](#local-distributed-transcoding)
- [Outsourced Transcoding (requires payment in ETH)](#outsourced-transcoding)

### Transcoding Overview

Livepeer Broadcaster can be configured to request that source video content be resized (transcoded) into different frame sizes and frame rates.

Transcoding allows content to be consumed by devices with less-performant network connections (bytes per second).

![Vector_Video_Standards8](https://user-images.githubusercontent.com/2212651/115254515-0b5a0480-a14b-11eb-97de-5b9b8f2fa3e0.png)
This chart shows the most common display resolutions, 16:9 formats shown in blue. [source: Wikipedia](https://en.wikipedia.org/wiki/1080p#/media/File:Vector_Video_Standards8.svg)

[Return to main page](./README.md#next-steps)

### Local Transcoding

![image](https://github.com/videoDAC/livepeer-broadcaster/assets/2212651/8e795b45-d516-45b2-9597-af2f85170e8a)

Transcoding can be performed on the same computer / server running the Livepeer Broadcaster.

1. Open a `Terminal`, and run the following command from the folder containing `livepeer` binary:
```
./livepeer \
        -broadcaster \
        -orchAddr 127.0.0.1:8935 \
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
        -serviceAddr 127.0.0.1:8935 \
        -v 99
```
  - `-orchestrator` and `-transcoder` tell the software to run in Orchestrator and Transcoder modes
  - `-serviceAddr` specifies the IP address and port that this service should run on the network
  - `-v 99` is the highest level of logging output.

**Livepeer Broadcaster is now running with Local Transcoding enabled.**

3. Start publishing content as described in [the page about publishing and consuming content](./publish-and-consume-content.md)

4. [Inspect the content metadata](publish-and-consume-content.md#inspect-content-metadata) to see the additional streams available for consumption:

![image](https://github.com/videoDAC/livepeer-broadcaster/assets/2212651/4fadc4ce-0c79-46a6-809c-df67b8c8febc)

Note: many players of streaming content will dynamically switch between available streams in order to optimise the quality of playback given the available bandwidth.

[Return to main page](./README.md#next-steps)

### Local Distributed Transcoding

![image](https://github.com/videoDAC/livepeer-broadcaster/assets/2212651/42583d9c-927f-422b-b23b-8b29fa7a3f36)

Transcoding activities can also be distributed across an Orchestrator, and one or more Transcoders.

1. Open a `Terminal`, and run the following command from the folder containing `livepeer` binary:
```
./livepeer \
        -broadcaster \
        -orchAddr 127.0.0.1:8935 \
        -transcodingOptions P144p30fps16x9,P240p30fps16x9 \
        -v 99
```

2. Open another `Terminal`, and run the following command from the folder containing `livepeer` binary:
```
./livepeer \
        -orchestrator \
        -orchSecret pineapple \
        -serviceAddr 127.0.0.1:8935 \
        -v 99
```
  - `-orchSecret` is a way for this Orchestrator to allow Transcoders to authenticate

3. Open another `Terminal`, and run the following command from the folder containing `livepeer` binary:
```
./livepeer \
        -transcoder \
        -orchSecret pineapple \
        -orchAddr 127.0.0.1:8935 \
        -v 99
```

**Livepeer Broadcaster is now running with (Local) Distributed Transcoding enabled.**

[Return to main page](./README.md#next-steps)

### Outsourced Transcoding (requires ETH on Arbitrum One)

Transcoding services can be purchased directly from individual Orchestrators operating in Livepeer's public Transcoding Marketplace. Services are provided on a pay-as-you-go basis using Ether as currency, and Arbitrum One for payment clearing. Arbitrum One is a Layer 2 Optimistic Rollup on Ethereum.

1. Obtain an RPC endpoint onto Arbitrum, using [Alchemy](https://www.alchemy.com/) (requires sign-up). Alternatively, run your own Arbitrum RPC endpoint using [these instructions](https://docs.arbitrum.io/run-arbitrum-node/quickstart).

2. Open another `Terminal` and run the following command:
```
./livepeer \
        -broadcaster \
        -network arbitrum-one-mainnet \
        -transcodingOptions P144p30fps16x9,P240p30fps16x9 \
        -ethUrl {insert RPC endpoint here} \
        -pixelsPerUnit 1 \
        -maxPricePerUnit 1 \
        -v 99
```
  - `arbitrum-one-mainnet` signifies Arbitrum One network.
  - `-ethUrl` is the location of the RPC endpoint e.g. from Alchemy.
  - `-pixelsPerUnit` and `-maxPricePerUnit` are for setting the maximum price to be paid for Transcoding

3. Enter a Passphrase twice:

![image](https://github.com/videoDAC/livepeer-broadcaster/assets/2212651/bd9c4d14-0558-4fbc-b21a-f6f878c08a1e)

Note: no characters will appear in the window when typing the passphrase.

The Passphrase will be used to encrypt the Private Key generated by this process. The Private Key will be used to sign transactions for publishing on Ethereum.

4. Enter the Passphrase again to start the Livepeer Broadcaster.

5. Wait until the text `CLI server listening on 127.0.0.1:5935` is displayed in the console:

![image](https://github.com/videoDAC/livepeer-broadcaster/assets/2212651/14818484-b996-46ae-bdd6-d603aa0e5540)

8. Open a `Terminal`, and run the following command from the folder containing `livepeer_cli` binary:
```
./livepeer_cli -http 5935
```

9. Send some ETH from your wallet to the `Broadcaster Account` listed under `NODE STATS`.

10. In `livepeer_cli`, run option `11. Invoke "deposit broadcasting funds" (ETH)`

![image](https://github.com/videoDAC/livepeer-broadcaster/assets/2212651/e9d9fd59-fc1f-4e9c-a645-5e81fc734abc)

This command will deposit some ETH into a smart contract in Livepeer's protocol, which can be spent on Transcoding services.

11. Enter the amount of ETH you would like to deposit into the contract.

12. Enter the amount of ETH you would like to keep in reserve in the contract, and press return.

**Livepeer Broadcaster is now running with Outsourced Transcoding on Livepeer, with payment on Ethereum.**

You can now stream content into Livepeer Broadcaster, and observe that your content is being transcoded into different formats.

Further details on setting the maximum price to be paid for Transcoding can be found in [Livepeer's Broadcaster documentation](https://livepeer.readthedocs.io/en/latest/broadcasting.html).

To find out more about Livepeer, go to this [10-minute primer](https://livepeer.org/primer/).

[Return to main page](./README.md#next-steps)
