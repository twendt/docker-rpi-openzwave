# Docker container for Raspberry Pi with openzwave and NodeJS

This container includes NodeJS, openzwave and the openzwave control panel. By default it will 
start a mini webserver on port 8888. This can be used to configure the Z-Wave network.

NodeJS is included, bevause it can be used as a base image for a Z-Wave controller using 
Node Red.

## Usage

The container is stateless and therefore does not need any volumes.

```
docker run -d -p 8888:8888 --device /dev/ttyACM0 rpi-openzwave
```

Since it is not deployed on Docker Hub, it needs to be build from this repo first.  
I have not included the needed qemu-arm-static in this repo, that can be downloaded from 
https://github.com/multiarch/qemu-user-static/releases

```
git clone git@github.com:twendt/docker-rpi-openzwave.git
cd docker-rpi-openzwave
docker build -t rpi-openzwave .
```
