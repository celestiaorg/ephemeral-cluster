# Ephemeral Cluster

This repository contains contiguration files and related scripts to starting Celestia and/or Cevmos clusters using docker compose 

## Dependencies
You must have both Docker and Docker Compose installed

Install Docker: (https://docs.docker.com/engine/install/)  
Install Docker Compose: (https://docs.docker.com/compose/install/)

## Setup
> ⚠ Because git doesn't store exact file permissions the preexisting nodekeys for the bridge and light nodes must have the correct permissions set manually.  
> The first time you setup the cluster you should run
> ```
> chmod 0600 celestia-node/full/*/nodekey* && \
> chmod 0600 celestia-node/light/*/nodekey* && \
> chmod 0600 dalc/celestia-app/celestia-light-keys
> ```
> This is done for you if you use the provided setup scripts in `scripts/`

## Minimal Celestia Cluster
![](min-celestia.png "Minimum Viable Celestia Cluster")
*Minimal Celestia Cluster*
```
scripts/minimal-celestia.sh
```

## Celestia Cluster w/ P2P Communication
```
scripts/full-celestia.sh
```

## Minimal Cevmos Cluster

![](min-cevmos.png "Minimum Viable Cevmos Cluster")
*Minimal Cevmos Cluster*

To setup the docker compose cluster run
```
scripts/minimal-cevmos.sh
```

## Cevmos Cluster w/ P2P Communication
```
scripts/full-cevmos.sh
```

> This will take about a minute to complete because you must wait for the core nodes to generate an initial block before the full nodes can be started. You must then wait for the full nodes to sync the block before starting the light nodes.

A successful startup of the cluster should result in 13 total docker containers running. You can verify the running containers with `docker ps`

Each container in the cluster has its own static IP Address:
| Component | IP Address |
| --------- | ---------- |
| Core Node(s) | 192.167.10.2 - 192.167.10.5 |
| Bridge Nodes(s) | 192.167.10.6 - 192.167.10.9 |
| Light Nodes(s) | 192.167.10.10 - 192.167.10.13 |
| DALC | 192.167.10.14 |

### Interacting with the cluster

All containers run on the same docker compose network `docker_localnet`. The easiest way to reach a container is to run curl from a docker container within the network.

A single call to `core0` retrieving the first block:
```
docker run --network docker_localnet --rm curlimages/curl:7.80.0 -s "192.167.10.2:26657/block?height=1"
```

Docker compose also sets up DNS within the network so you can reference a given container by its name
```
docker run --network docker_localnet --rm curlimages/curl:7.80.0 -s "core0:26657/block?height=1"
```

To start an interactive session on a curl container
```
docker run -it --network docker_localnet curlimages/curl:7.80.0 bash
```

### Other Useful Commands

Retrieve logs from all core nodes
```
docker-compose -f docker/core-docker-compose.yml logs
```
Retrieve logs from all bridge nodes
```
docker-compose -f docker/bridge-docker-compose.yml logs
```
Retrieve logs from all light nodes
```
docker-compose -f docker/light-docker-compose.yml logs
```
Retrieve logs from all DALC nodes
```
docker-compose -f docker/dalc-docker-compose.yml logs
```

### Teardown

To stop the docker compose cluster run
```
./teardown-docker-cluster.sh
```
