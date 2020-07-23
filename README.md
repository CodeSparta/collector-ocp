# Koffer Collector | OpenShift Infrastructure Deploy
## Provides
This automation provides a unified and standardized tarball of artifacts for
airgap infrastructure deployment tasks.

## About
Koffer Collector OpenShift uses the Koffer Engine runtime container to enable
streamlined low side capture of all required artifacts for deploying OpenShift 
infrastructure. Primarily built to enable airgaped environments in a standard 
"registry < to > mirror" workflow model conventional to more typical connected 
local mirror techniques.

Features:
  - High side sha256 verification of artifacts bundle before standup
  - High side artifact delivery via script to run `cloudctl` podman pod running:
    - Nginx for serving CoreOS Ignition files
    - Generic Docker Registry:2 for serving pre-hydrated image content
    - ContainerOne user automation deployment and development workspace
  - Bastion host support for CoreOS or any Podman capable distribution
  - Low side injestion direct to "pre-hydrated" registry stateful path

## Instructions:
### 1. Run Infrastructure Collector with Koffer Engine
```
 mkdir -p /tmp/platform ; \
 sudo podman run \
     --volume /tmp/platform:/root/deploy:z     \
     --rm -it --entrypoint=/usr/bin/entrypoint \
   docker.io/containercraft/koffer:latest      \
   https://repo1.dsop.io/dsop/redhat/platformone/ocp4x/ansible/collector-infra.git latest

```
### 2. Move Koffer Bundle to target host /tmp directory
# [Developer Docs & Utils](./dev)
# Demo
![bundle](./web/bundle.svg)
