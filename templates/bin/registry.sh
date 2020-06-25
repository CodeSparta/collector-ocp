#!/bin/bash -e

if [[ ! -d ./PlatformOne ]]; then
 #sha256sum --check PlatformOne.tar.gz.sha256
  tar xvf PlatformOne.tar.gz
  runUser="$USER"
fi

p1DirImages=${HOME}/PlatformOne/images
envFile=$(ls ${HOME}/PlatformOne/*/environment)
source ${envFile}

sudo chown -R ${runUser}:${runUser} ${HOME}/PlatformOne
sudo chmod -R 755 ${HOME}/PlatformOne/${p1ClusterDomain}/data
mkdir  ${HOME}/PlatformOne/${p1ClusterDomain}/registry 2>/dev/null

run_clean () {
  for container in $( sudo podman ps | awk '/one|nginx|registry|pause|busybox/{print $3}' 2>/dev/null); do
    sudo podman rm --force $container
  done
  for pod in $( sudo podman pod ps | awk '/registry/{print $1}' 2>/dev/null); do
    sudo podman pod rm --force $pod
  done
  for image in $( sudo podman images | awk '/one|nginx|registry/{print $3}' 2>/dev/null); do
    sudo podman rmi --force $image
  done
}

load_images () {
  for image in $(ls ${p1DirImages}/*.tar); do
    sudo podman load -i ${image}
  done
}

load_mirror_certificate () {
sudo cp ${p1DirArtifacts}/ssl/${p1ClusterDomain}.crt \
       /etc/pki/ca-trust/source/anchors/${p1ClusterDomain}.crt \
     && sudo update-ca-trust
}

write_mirror_credentials () {
sudo podman run \
        --rm                                          \
        --entrypoint htpasswd                         \
      registry:2                                      \
        -Bbn ${p1NameVpc} ${p1NameVpc} > ${p1DirArtifacts}/auth/htpasswd
}

run_pod () {
  sudo podman play kube ./registry.yml
}

run_core () {
  run_clean
  load_images
  load_mirror_certificate
  write_mirror_credentials
  run_pod
}

test_core () {
  echo " >> List Pods & Containers"
  sudo podman pod ps
  sudo podman ps --all
  
  echo " >> Testing NGINX Ignition Service"
  ignTest=$(curl http://10.88.0.1:8080/bootstrap.ign 2>&1 1>/dev/null ; echo $?)
  [[ ${ignTest} == '0' ]] && echo 'NGINX Ignition Service Check Failed!'

  echo " >> Testing Docker Registry:2 Service"
  ignTest=$(curl -u ${p1NameVpc}:${p1NameVpc} -k https://10.88.0.1:5000/v2/_catalog 2>&1 1>/dev/null ; echo $?)
  [[ ${ignTest} == '0' ]] && echo 'NGINX Ignition Service Check Failed!'
}

run_core
test_core
