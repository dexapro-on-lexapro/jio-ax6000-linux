# JioRouter AX6000 Linux Appliances (Debian 12 & Alpine Linux ARM64)

Standalone ARM64 Linux operating system appliances, root filesystems, and bootable storage images for the **JioRouter AX6000** family, supporting both **Qualcomm IPQ9554** (JIDU6J11 Series) and **MediaTek MT7986A Filogic 830** (JIDU6101 & JIDU6J01 Series).

---

## 🌟 Overview & System Highlights

These Linux builds transform the Jio AX6000 router into an **ARM64 (quad-core Cortex-A53) mini-server**, enabling execution of standard Linux applications, container runtimes (Docker, Podman), and enterprise networking services alongside or in place of OpenWrt.

### 1. Debian 12 (Bookworm) ARM64 Bootable Storage Image
* **Target Architecture:** `aarch64` / ARM64 (Cortex-A53).
* **Base System:** Debian 12 (Bookworm) official release with modern `systemd` init.
* **Storage Format:** Ready-to-use raw ext4 disk image (`jio-ax6000-debian12-arm64-usb.img.gz`), sized for USB 3.0 flash drives and SSDs.
* **Console Access:** Serial UART consoles enabled on boot:
  * Qualcomm IPQ9554 UART: `ttyMSM0` (115200 baud, 8N1)
  * MediaTek MT7986A UART: `ttyS0` (115200 baud, 8N1)
* **Networking:** Hotplug DHCP pre-configured on Ethernet (`eth0`) and USB cellular/mobile tethering interfaces (`usb0`).
* **Package Management:** Full access to standard Debian upstream APT repositories (`apt update && apt install ...`).
* **Use Cases:** Home lab mini-server, Docker host, Pi-hole DNS server, database host, WireGuard gateway.

### 2. Alpine Linux 3.20 (ARM64) Micro-Router Rootfs
* **Target Architecture:** `aarch64` / ARM64 (Cortex-A53).
* **Base System:** Alpine Linux 3.20 with `musl libc` and OpenRC init.
* **Storage Footprint:** Ultra-compact rootfs archive (`jio-ax6000-alpine320-arm64-rootfs.tar.gz`), under **6 MB** compressed.
* **Execution Model:** Optimized for in-memory (RAM) execution, minimizing flash wear and boot latency.
* **Kernel Driver Support:** Integrated 6.18.55 Linux router kernel modules (`/lib/modules/6.18.55/`) for Ethernet, Wi-Fi, and USB storage/tethering.
* **Console Access:** Configured for `ttyMSM0` and `ttyS0` UART consoles at 115200 baud.
* **Package Management:** Native `apk` package manager with access to Alpine package mirrors.
* **Use Cases:** Lightweight container host, fast-boot rescue environment, ultra-low-latency network appliance.

---

## 📦 Supported Hardware SKUs & Pre-compiled Binaries

Pre-compiled production images and cryptographic checksums are available in the **[v2026.10.30 Release](https://github.com/dwaipayandex/jio-ax6000-linux/releases/tag/v2026.10.30)**.

| Hardware SKU | Architecture | SoC / Platform | Memory | Supported Linux Images |
| :--- | :--- | :--- | :--- | :--- |
| **JIDU6111** | ARM64 | Qualcomm IPQ9554 | 512 MB DDR4 | Debian 12 ARM64 & Alpine 3.20 ARM64 |
| **JIDU6411** | ARM64 | Qualcomm IPQ9554 | 512 MB DDR4 | Debian 12 ARM64 & Alpine 3.20 ARM64 |
| **JIDU6611** | ARM64 | Qualcomm IPQ9554 | 512 MB DDR4 | Debian 12 ARM64 & Alpine 3.20 ARM64 |
| **JIDU6811** | ARM64 | Qualcomm IPQ9554 | 512 MB DDR4 | Debian 12 ARM64 & Alpine 3.20 ARM64 |
| **JIDU6911** | ARM64 | Qualcomm IPQ9554 | 512 MB DDR4 | Debian 12 ARM64 & Alpine 3.20 ARM64 |
| **JIDU6101** | ARM64 | MediaTek MT7986A Filogic 830 | 512 MB DDR3/4 | Debian 12 ARM64 & Alpine 3.20 ARM64 |
| **JIDU6J01** *(6201, 6401, 6601, 6701, 6801)* | ARM64 | MediaTek MT7986A Filogic 830 | 512 MB DDR3/4 | Debian 12 ARM64 & Alpine 3.20 ARM64 |

### Published Release Artifacts

| Image Artifact | Format | Description | Checksum (SHA-256) |
| :--- | :--- | :--- | :--- |
| `jio-ax6000-debian12-arm64-usb.img.gz` | Gzipped Raw Disk Image | Full Debian 12 Bookworm ARM64 bootable image for USB 3.0 storage. | `577735d506bb0da652d765b093186e825a159e35d0b2abfcfbfb48cca9e7b6a9` |
| `jio-ax6000-alpine320-arm64-rootfs.tar.gz` | Tarball Rootfs Archive | Minimal Alpine Linux 3.20 ARM64 root filesystem for RAM or flash overlay. | `c9710aae6be3f27b2e93be224cc899bba84d612df78cb3ac8db60ba2060a7ece` |

---

## 🛠️ Building From Source

To rebuild these root filesystems and disk images from scratch:

1. **Clone this repository:**
   ```bash
   git clone https://github.com/dwaipayandex/jio-ax6000-linux.git
   cd jio-ax6000-linux
   ```

2. **Execute the build pipeline:**
   ```bash
   chmod +x build.sh
   ./build.sh
   ```

All generated tarballs, disk images, and SHA256 checksums will be placed in the `binaries/` directory.

---

## 🤖 AI Assistance & Transparency Disclosure

In compliance with open-source engineering transparency and AI attribution standards:
* **Tool:** Assisted by **Google Antigravity / Gemini Advanced Agentic Coding**.
* **Scope of Assistance:** Rootfs automation pipelines, cross-architecture serial console configuration, kernel module injection scripting, and multi-server orchestration.
* **Human Oversight:** Hardware verification, repository oversight, and direction by [@dwaipayandex](https://github.com/dwaipayandex).

---

## 🙏 Credits & Acknowledgments

* **[Debian Project](https://www.debian.org/)** — Universal Operating System ARM64 release images.
* **[Alpine Linux](https://alpinelinux.org/)** — Lightweight, security-oriented Linux distribution.
* **[OpenWrt Project](https://openwrt.org/)** — Kernel infrastructure and driver baseline.
* **[@Sandiep](https://github.com/Sandiep)** — Baseline hardware reverse engineering on the Qualcomm IPQ9554 (JIDU6J11) platform.
* **[@themayankraut](https://github.com/themayankraut)** — Hardware documentation and SKU identification for the Jio AX6000 router family.

---

## ⚖️ License & Disclaimer

* **License:** This project is licensed under the [GNU General Public License v2.0 (GPL-2.0)](LICENSE).
* **Disclaimer:** Custom firmware modifications carry inherent risks. This repository provides source scripts, configuration files, and build artifacts for development, educational, and testing purposes only. No warranties or guarantees of fitness for a particular purpose are expressed or implied.
