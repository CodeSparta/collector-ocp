# The Real NAPS-ter Official (TRNO) | AWS Red Hat OpenShift 4 | Deployment Prep Tools
## 1. Create base ArtifactBundle asset images & directories
```
mkdir -p ${HOME}/TRNO
```
## 2. Launch ContainerOne Point of Origin Container
```
sudo podman run -dq -h one --name one --privileged --volume ${HOME}/TRNO:/root/deploy:z docker.io/containercraft/one:nightlies
```
## 3. Exec into ContainerOne
```
sudo podman exec -it one connect
```
## 4.\* Setup environment
Run the `p1` initial artifact setup walkthrough:
```
p1
```
# Demo:
  - Building the bundle    
![bundle](./web/bundle.svg)
