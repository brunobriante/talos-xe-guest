FROM golang:1.18
WORKDIR /opt
RUN git clone https://github.com/brunobriante/xe-guest-utilities.git
WORKDIR /opt/xe-guest-utilities
RUN git checkout 7.30.0-8.2
RUN go mod vendor
RUN mkdir vendor/xe-guest-utilities
RUN make
WORKDIR /opt/xe-guest-utilities/build/dist
RUN tar zxvf xe-guest-utilities_6.6.80-158_x86_64.tgz

FROM scratch
WORKDIR /rootfs/
COPY ./xe-daemon.yaml /rootfs/usr/local/etc/containers/xe-daemon.yaml
COPY ./manifest.yaml /
COPY --from=0 /opt/xe-guest-utilities/build/dist/etc/udev/rules.d/ /rootfs/usr/etc/udev/rules.d/
COPY --from=0 /opt/xe-guest-utilities/build/dist/usr/sbin/xe-daemon /rootfs/usr/local/lib/containers/xe-daemon/sbin/xe-daemon
COPY --from=0 /opt/xe-guest-utilities/build/dist/usr/bin /rootfs/usr/local/lib/containers/xe-daemon/bin