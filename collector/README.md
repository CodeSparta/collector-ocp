# [Koffer](https://github.com/containercraft/Koffer) Collector Plugin | OpenShift Infrastructure Artifacts
This automation provides a unified and standardized tarball of OpenShift artifacts for
restricted or airgap infrastructure deployment.

Features:
  - CloudCtl compatible
  - Low side SHA256 artifact bundle metadata (for high side bit integrity validation)
  - Low side injestion direct to "pre-hydrated" registry stateful path
  - Idempotent, can be used to additively upload artifacts to pre-existing collection

## Usage: Execute Collector Plugin with Koffer Engine
```
mkdir -p ${HOME}/bundle && \
sudo podman run -it --rm --pull always \
    --volume /tmp/platform:/root/bundle:z \
  docker.io/containercraft/koffer:latest bundle \
    --plugin collector-infra
```
