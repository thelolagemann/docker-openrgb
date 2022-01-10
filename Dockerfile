FROM thelolagemann/qt5-builder:latest as builder

ARG OPENRGB_RELEASE=0.7

RUN apk update && \
    apk add --no-cache \
    mbedtls-dev \
    hidapi-dev \
    libusb-dev
RUN git clone "https://gitlab.com/CalcProgrammer1/OpenRGB.git"
RUN qmake "/build/OpenRGB/OpenRGB.pro"
RUN make -j$(nproc)

FROM alpine:3.15

# runtime deps
RUN apk add --no-cache \
    qt5-qtbase-x11 \
    mbedtls \
    hidapi \
    ttf-dejavu \
    mesa-dri-swrast

RUN ln -s /root/.config/OpenRGB /config
    
COPY --from=builder /build/openrgb /usr/bin/openrgb

ENTRYPOINT ["/bin/ash", "-l", "-c"]
CMD ["openrgb --gui --noautoconnect --server"]
