## Transcoding

Livepeer Broadcaster can be configured to transcode the source content into different frame sizes and frame rates.

Transcoding allows content to be consumed by devices with less-performant network connections (bytes per second).

[Return to main page](./README.md#next-steps)

### Local Transcoding

![image](https://user-images.githubusercontent.com/2212651/112747032-6f682d80-8fd0-11eb-9bcc-c5e8851e4c44.png)

Transcoding can be performed on the same computer / server running the Livepeer Broadcaster.

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

**Livepeer Broadcaster is now running with Local Transcoding enabled.**

3. [Inspect the content metadata](#inspect-content-metadata) to see the additional streams available for consumption:

![image](https://user-images.githubusercontent.com/2212651/80700605-9cc80500-8afb-11ea-9ef4-b041b7f39a55.png)

Note: many players of streaming content will dynamically switch between available streams in order to optimise the quality of playback given the available bandwidth.

[Return to main page](./README.md#next-steps)

### Local Distributed Transcoding

![image](https://user-images.githubusercontent.com/2212651/112747170-33819800-8fd1-11eb-86e3-293cf12b0169.png)

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

**Livepeer Broadcaster is now running with (Local) Distributed Transcoding enabled.**

[Return to main page](./README.md#next-steps)

### Remote Transcoding

Transcoding can also be performed on a different computer / server from the Livepeer Broadcaster.

For this you will need two hosts (computers / servers):

- For the Livepeer Broadcaster
  - This host will need to be able to connect to port `8936` on the host of the remote transcoder.
- For the remote Transcoder

1. Open a `Terminal` on the Livepeer Broadcaster host, and run the following command:
```
./livepeer \
        -broadcaster \
        -orchAddr 192.168.2.113:8936 \
        -transcodingOptions P144p30fps16x9,P240p30fps16x9 \
        -v 99
```
  - `192.168.2.113` is the IP address of the remote transcoder host

2. Open a `Terminal` on the remote Transcoder host, and run the following command:
```
./livepeer \
        -orchestrator \
        -transcoder \
        -serviceAddr 192.168.2.113:8936 \
        -cliAddr 127.0.0.1:7936 \
        -v 99
```
  - `192.168.2.113` is the IP address of the remote transcoder host

**Livepeer Broadcaster is now running with Remote Transcoding enabled.**

[Return to main page](./README.md#next-steps)

### Outsourced Transcoding (requires payment in Ethereum)

Transcoding services can be purchased directly from individual Orchestrators operating in Livepeer's public Transcoding Marketplace.

Services are provide on a pay-as-you-go basis using Ethereum.

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

6. Enter the Passphrase again to start the Livepeer Broadcaster.

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

12. Enter the amount of ETH you would like to keep in reserve in the contract, and press return.

**Livepeer Broadcaster is now running with Outsourced Transcoding on Livepeer, with payment on Ethereum.**

You can now stream content into Livepeer Broadcaster, and observe that your content is being transcoded into different formats.

Further details on setting the maximum price to be paid for Transcoding can be found in [Livepeer's Broadcaster documentation](https://livepeer.readthedocs.io/en/latest/broadcasting.html).

To find out more about Livepeer, go to this [10-minute primer](https://livepeer.org/primer/).

[Return to main page](./README.md#next-steps)
