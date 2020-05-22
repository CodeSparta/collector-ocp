# PlatformOne | AWS Fences Airgap Cluster Deploy Manual - Red Hat OpenShift 4

## 1. Create base PlatformOne & images asset directories
```
mkdir -p ${HOME}/PlatformOne/images
```
## 2.\* Pull required deployment images    
```
podman pull docker.io/library/registry:2 
podman pull docker.io/library/nginx:latest 
podman pull quay.io/containercraft/one:fences
```
## 3.\* Export images for airgapped services
```
podman save -o ${HOME}/PlatformOne/images/docker-registry2-image.tar     registry:2 
podman save -o ${HOME}/PlatformOne/images/docker-nginxlatest-image.tar   nginx:latest
podman save -o ${HOME}/PlatformOne/images/docker-one-image.tar containercraft/one:fences
```
## 4. Launch ContainerOne Point of Origin Container
```
podman run -d -h fences --name fences --privileged --volume ${HOME}/PlatformOne:/root/PlatformOne:z quay.io/containercraft/one:fences
```
## 5. Exec into ContainerOne
```
podman exec -it fences connect
```
## 6.\* Setup environment

Run the `p1` initial artifact setup walkthrough:
```
p1
```

# Demo:
  - Building the bundle
![bundle](./web/bundle.svg)
