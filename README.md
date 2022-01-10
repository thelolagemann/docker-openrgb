# docker-openrgb

A small docker container for running [OpenRGB](https://gitlab.com/CalcProgrammer1/OpenRGB).

> :warning: **OpenRGB requires low level access to your hardware, using it incorrectly could result in permanently 
> bricked devices. Make sure to read through the warning section of the official project page very carefully.**

## Usage

**Docker run**
```shell
docker run --rm \
  --privileged \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /config:/config \
  -e DISPLAY=unix$DISPLAY \
  -p 6742:6742 \
  thelolagemann/openrgb:latest
```

**Docker Compose**

```yaml
version: "3.9"

services:
  openrgb:
    container_name: openrgb
    image: thelolagemann/openrgb:latest
    volumes:
      - /config:/config
      - /tmp/.X11-unix:/tmp/.X11-unix
    environment:
      - DISPLAY=unix$DISPLAY
    ports:
      - "6742:6742"
    privileged: true
```
<sup>This container requires the privileged flag in order to be able to communicate with your hardware. </sup>