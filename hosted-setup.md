## Hosted Setup

A Livepeer Broadcaster can be deployed on a hosted server. For this guide it is assumed that this hosted server is running Linux (Ubuntu).

[Return to main page](./README.md#next-steps)

### Livepeer Broadcaster Access Options

It is necessary to configure Livepeer Broadcaster appropriately, in order to allow required remote access to the server.

#### Local publish and consume only (no remote access)

When starting Livepeer Broadcaster, run the following command:
```
./livepeer \ 
        -broadcaster \
        -rtmpAddr 127.0.0.1:1935 \
        -httpAddr 127.0.0.1:8935
```
_Note: this command is technically equivalent to running the same command without `-rtmpAddr` or `-httpAddr` flags, as these are the default options. They are explicitly included here for illustrative purposes only._

Livepeer Broadcaster will _only allow content to be published and consumed on the hosted server itself_:

|        | publish | consume |
|--------|:-------:|:-------:|
| local  |   yes   |   yes   |
| remote |    no   |    no   |

[Return to main page](./README.md#next-steps)

#### Local publish, Remote consume

When starting Livepeer Broadcaster, run the following command:
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

[Return to main page](./README.md#next-steps)

#### Remote publish and consume (full remote access)

When starting Livepeer Broadcaster, run the following command:
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

[Return to main page](./README.md#next-steps)
