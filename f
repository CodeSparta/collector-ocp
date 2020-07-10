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
### 1. Clone into koffer directory
```
 mkdir /tmp/platform
 git clone https://repo1.dsop.io/dsop/redhat/platformone/ocp4x/ansible/bundle.git /tmp/bundle && cd /tmp/bundle && git checkout nightlies;
```
### 2. Run Koffer Engine
```
 sudo podman run \
     --rm -it -h koffer --name koffer      \
     --pull=always --entrypoint entrypoint \
     --volume /tmp/bundle:/root/koffer:z   \
     --volume /tmp/platform:/root/deploy:z \
   docker.io/containercraft/koffer:nightlies
```
### 3. Move Koffer Bundle to target host /tmp directory
# [Developer Docs & Utils](./dev)
# Demo
![bundle](./web/bundle.svg)
