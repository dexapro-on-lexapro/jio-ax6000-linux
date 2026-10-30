#!/bin/bash
# JioRouter AX6000 Linux Appliances & Rootfs Generator
# Targets: Qualcomm IPQ9554 & MediaTek MT7986A Filogic 830 (ARM64 / aarch64)
# Supported Distributions: Alpine Linux 3.20 & Debian 12 (Bookworm)

set -e

WORK_DIR="$(pwd)/workspace"
OUT_DIR="$(pwd)/binaries"
CONFIG_DIR="$(pwd)/configs"

mkdir -p "$WORK_DIR" "$OUT_DIR"

echo "=== Building Alpine Linux 3.20 (ARM64) Micro-Router Rootfs ==="
mkdir -p "$WORK_DIR/alpine"
cd "$WORK_DIR/alpine"
if [ ! -f alpine-minirootfs.tar.gz ]; then
    echo "Downloading Alpine 3.20 aarch64 minirootfs..."
    curl -sL https://dl-cdn.alpinelinux.org/alpine/v3.20/releases/aarch64/alpine-minirootfs-3.20.3-aarch64.tar.gz -o alpine-minirootfs.tar.gz
fi

rm -rf rootfs && mkdir -p rootfs
tar -xzf alpine-minirootfs.tar.gz -C rootfs/

# Network & System configuration
cat << 'NET' > rootfs/etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
NET

cat << 'RESOLV' > rootfs/etc/resolv.conf
nameserver 1.1.1.1
nameserver 8.8.8.8
RESOLV

echo "jio-ax6000" > rootfs/etc/hostname

# Enable hardware UART consoles
echo "ttyMSM0" >> rootfs/etc/securetty
echo "ttyS0" >> rootfs/etc/securetty
echo "ttyMSM0::respawn:/sbin/getty -L ttyMSM0 115200 vt100" >> rootfs/etc/inittab
echo "ttyS0::respawn:/sbin/getty -L ttyS0 115200 vt100" >> rootfs/etc/inittab

# Package Alpine rootfs
tar -czf "$OUT_DIR/jio-ax6000-alpine320-arm64-rootfs.tar.gz" -C rootfs/ .
echo "Generated: $OUT_DIR/jio-ax6000-alpine320-arm64-rootfs.tar.gz"


echo "=== Building Debian 12 (Bookworm) ARM64 Bootable Disk Image ==="
mkdir -p "$WORK_DIR/debian"
cd "$WORK_DIR/debian"
if [ ! -f debian-12-nocloud-arm64.tar.xz ]; then
    echo "Downloading Debian 12 Bookworm arm64 cloud/nocloud image..."
    curl -sL https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-nocloud-arm64.tar.xz -o debian-12-nocloud-arm64.tar.xz
fi

tar -xf debian-12-nocloud-arm64.tar.xz
if [ -f disk.raw ]; then
    echo "Compressing bootable Debian 12 USB disk image..."
    gzip -c disk.raw > "$OUT_DIR/jio-ax6000-debian12-arm64-usb.img.gz"
    echo "Generated: $OUT_DIR/jio-ax6000-debian12-arm64-usb.img.gz"
fi

cd "$OUT_DIR"
sha256sum jio-ax6000-* > SHA256SUMS
echo "=== All Linux builds completed successfully! ==="
