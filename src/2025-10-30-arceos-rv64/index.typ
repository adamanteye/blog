#import "../../page.typ": conf
#import "meta.typ": desc, title
#show: conf.with(
  title: title,
  desc: desc,
)

= ArceOS

#link("https://github.com/arceos-org/arceos")[ArceOS]
is an experimental modular operating system written in Rust.

As I am taking the OS course this semester, my job is to continue #link(
  "https://github.com/mingyang91/arceos",
)[Ming Yang's work]. He had implemented an async runtime for arceos and tested
DWMAC on #link(
  "https://doc-en.rvspace.org/VisionFive2/Product_Brief/VisionFive_2/introduction.html",
)[StarFive VisionFive 2 board].

And I am going to absruct his implemenation, move them into separate crate,
possily merge the async runtime for ArceOS too.

= StarFive VisionFive 2

StarFive VisionFive 2 is a 4 core, 64 bit, RV64GC SoC, with highest freq to 1.5
GHz.

The board includes LPDDR4 memory (up to 8 Gi) and onboard SD card slot, as well
as:
- 2 RJ45 gigabit ethernet ports
- M.2 M-key

= ArceOS module axasync

The first step is to #link(
  "https://github.com/adamanteye/arceos-mingyang",
)[build the Docker image], which prepares the environment for flashing the
kernel image onto the board.

The initial challenge I encountered was that Cargo crates failed to download,
even though policy routing was correctly configured on my software router along
with DNS zones and `static.crates.io` was reachable with a stable ping.

After tracing the connection using `curl`, I discovered that the issue was once
again related to the *MTU*. Having it set to `1420`, the problem solves.

As Ming Yang implemented an #link(
  "https://github.com/mingyang91/arceos/tree/main/modules/axasync",
)[async runtime] for ArceOS. Under the directory there is an example to start a
TCP server and client.

Check out commit `3584af374ed5b9304de69cf264258c06371a1fbf` and run it on QEMU:

```sh
make A=examples/async_server ARCH=riscv64 PLATFORM=riscv64-qemu-virt LOG=debug NET=y SMP=1 BUS=mmio FEATURES=net,bus-mmio APP_FEATURES=default run
```

```
OpenSBI v1.5.1
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name             : riscv-virtio,qemu
Platform Features         : medeleg
Platform HART Count       : 1
Platform IPI Device       : aclint-mswi
Platform Timer Device     : aclint-mtimer @ 10000000Hz
Platform Console Device   : uart8250
Platform HSM Device       : ---
Platform PMU Device       : ---
Platform Reboot Device    : syscon-reboot
Platform Shutdown Device  : syscon-poweroff
Platform Suspend Device   : ---
Platform CPPC Device      : ---
Firmware Base             : 0x80000000
Firmware Size             : 327 KB
Firmware RW Offset        : 0x40000
Firmware RW Size          : 71 KB
Firmware Heap Offset      : 0x49000
Firmware Heap Size        : 35 KB (total), 2 KB (reserved), 11 KB (used), 21 KB (free)
Firmware Scratch Size     : 4096 B (total), 416 B (used), 3680 B (free)
Runtime SBI Version       : 2.0

Domain0 Name              : root
Domain0 Boot HART         : 0
Domain0 HARTs             : 0*
Domain0 Region00          : 0x0000000000100000-0x0000000000100fff M: (I,R,W) S/U: (R,W)
Domain0 Region01          : 0x0000000010000000-0x0000000010000fff M: (I,R,W) S/U: (R,W)
Domain0 Region02          : 0x0000000002000000-0x000000000200ffff M: (I,R,W) S/U: ()
Domain0 Region03          : 0x0000000080040000-0x000000008005ffff M: (R,W) S/U: ()
Domain0 Region04          : 0x0000000080000000-0x000000008003ffff M: (R,X) S/U: ()
Domain0 Region05          : 0x000000000c400000-0x000000000c5fffff M: (I,R,W) S/U: (R,W)
Domain0 Region06          : 0x000000000c000000-0x000000000c3fffff M: (I,R,W) S/U: (R,W)
Domain0 Region07          : 0x0000000000000000-0xffffffffffffffff M: () S/U: (R,W,X)
Domain0 Next Address      : 0x0000000080200000
Domain0 Next Arg1         : 0x0000000087e00000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes
Domain0 SysSuspend        : yes

Boot HART ID              : 0
Boot HART Domain          : root
Boot HART Priv Version    : v1.12
Boot HART Base ISA        : rv64imafdch
Boot HART ISA Extensions  : sstc,zicntr,zihpm,zicboz,zicbom,sdtrig,svadu
Boot HART PMP Count       : 16
Boot HART PMP Granularity : 2 bits
Boot HART PMP Address Bits: 54
Boot HART MHPM Info       : 16 (0x0007fff8)
Boot HART Debug Triggers  : 2 triggers
Boot HART MIDELEG         : 0x0000000000001666
Boot HART MEDELEG         : 0x0000000000f0b509

       d8888                            .d88888b.   .d8888b.
      d88888                           d88P" "Y88b d88P  Y88b
     d88P888                           888     888 Y88b.
    d88P 888 888d888  .d8888b  .d88b.  888     888  "Y888b.
   d88P  888 888P"   d88P"    d8P  Y8b 888     888     "Y88b.
  d88P   888 888     888      88888888 888     888       "888
 d8888888888 888     Y88b.    Y8b.     Y88b. .d88P Y88b  d88P
d88P     888 888      "Y8888P  "Y8888   "Y88888P"   "Y8888P"

arch = riscv64
platform = riscv64-qemu-virt
target = riscv64gc-unknown-none-elf
build_mode = release
log_level = debug
smp = 1

[  0.602015 0 axruntime:130] Logging is enabled.
[  0.612140 0 axruntime:131] Primary CPU 0 started, dtb = 0x87e00000.
[  0.616933 0 axruntime:133] Found physcial memory regions:
[  0.623056 0 axruntime:135]   [PA:0x80200000, PA:0x80222000) .text (READ | EXECUTE | RESERVED)
[  0.630700 0 axruntime:135]   [PA:0x80222000, PA:0x8022e000) .rodata (READ | RESERVED)
[  0.634468 0 axruntime:135]   [PA:0x8022e000, PA:0x80231000) .data .tdata .tbss .percpu (READ | WRITE | RESERVED)
[  0.639073 0 axruntime:135]   [PA:0x80231000, PA:0x80271000) boot stack (READ | WRITE | RESERVED)
[  0.644472 0 axruntime:135]   [PA:0x80271000, PA:0x80279000) .bss (READ | WRITE | RESERVED)
[  0.649163 0 axruntime:135]   [PA:0x80279000, PA:0x88000000) free memory (READ | WRITE | FREE)
[  0.654610 0 axruntime:135]   [PA:0x101000, PA:0x102000) mmio (READ | WRITE | DEVICE | RESERVED)
[  0.660095 0 axruntime:135]   [PA:0xc000000, PA:0xc210000) mmio (READ | WRITE | DEVICE | RESERVED)
[  0.665129 0 axruntime:135]   [PA:0x10000000, PA:0x10001000) mmio (READ | WRITE | DEVICE | RESERVED)
[  0.670399 0 axruntime:135]   [PA:0x10001000, PA:0x10009000) mmio (READ | WRITE | DEVICE | RESERVED)
[  0.675906 0 axruntime:135]   [PA:0x30000000, PA:0x40000000) mmio (READ | WRITE | DEVICE | RESERVED)
[  0.680950 0 axruntime:135]   [PA:0x40000000, PA:0x80000000) mmio (READ | WRITE | DEVICE | RESERVED)
[  0.686068 0 axruntime:213] Initialize global memory allocator...
[  0.689670 0 axruntime:214]   use TLSF allocator.
[  0.697060 0 axalloc:212] initialize global allocator at: [0xffffffc080279000, 0xffffffc088000000)
[  0.719259 0 axmm:72] Initialize virtual memory management...
[  0.728925 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc080200000, VA:0xffffffc080222000) -> [PA:0x80200000, PA:0x80222000) READ | EXECUTE
[  0.746960 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc080222000, VA:0xffffffc08022e000) -> [PA:0x80222000, PA:0x8022e000) READ
[  0.753211 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc08022e000, VA:0xffffffc080231000) -> [PA:0x8022e000, PA:0x80231000) READ | WRITE
[  0.760093 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc080231000, VA:0xffffffc080271000) -> [PA:0x80231000, PA:0x80271000) READ | WRITE
[  0.765501 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc080271000, VA:0xffffffc080279000) -> [PA:0x80271000, PA:0x80279000) READ | WRITE
[  0.771486 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc080279000, VA:0xffffffc088000000) -> [PA:0x80279000, PA:0x88000000) READ | WRITE
[  0.826803 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc000101000, VA:0xffffffc000102000) -> [PA:0x101000, PA:0x102000) READ | WRITE | DEVICE
[  0.834301 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc00c000000, VA:0xffffffc00c210000) -> [PA:0xc000000, PA:0xc210000) READ | WRITE | DEVICE
[  0.840709 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc010000000, VA:0xffffffc010001000) -> [PA:0x10000000, PA:0x10001000) READ | WRITE | DEVICE
[  0.846208 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc010001000, VA:0xffffffc010009000) -> [PA:0x10001000, PA:0x10009000) READ | WRITE | DEVICE
[  0.852089 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc030000000, VA:0xffffffc040000000) -> [PA:0x30000000, PA:0x40000000) READ | WRITE | DEVICE
[  0.957712 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc040000000, VA:0xffffffc080000000) -> [PA:0x40000000, PA:0x80000000) READ | WRITE | DEVICE
[  1.318930 0 axmm:75] kernel address space init OK: AddrSpace {
    va_range: VA:0xffffffc000000000..VA:0xfffffffffffff000,
    page_table_root: PA:0x80281000,
    areas: [
        MemoryArea {
            va_range: VA:0xffffffc000101000..VA:0xffffffc000102000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc00c000000..VA:0xffffffc00c210000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc010000000..VA:0xffffffc010001000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc010001000..VA:0xffffffc010009000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc030000000..VA:0xffffffc040000000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc040000000..VA:0xffffffc080000000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc080200000..VA:0xffffffc080222000,
            flags: READ | EXECUTE,
        },
        MemoryArea {
            va_range: VA:0xffffffc080222000..VA:0xffffffc08022e000,
            flags: READ,
        },
        MemoryArea {
            va_range: VA:0xffffffc08022e000..VA:0xffffffc080231000,
            flags: READ | WRITE,
        },
        MemoryArea {
            va_range: VA:0xffffffc080231000..VA:0xffffffc080271000,
            flags: READ | WRITE,
        },
        MemoryArea {
            va_range: VA:0xffffffc080271000..VA:0xffffffc080279000,
            flags: READ | WRITE,
        },
        MemoryArea {
            va_range: VA:0xffffffc080279000..VA:0xffffffc088000000,
            flags: READ | WRITE,
        },
    ],
}
[  1.390766 0 axruntime:150] Initialize platform devices...
[  1.398049 0 axdriver:155] Initialize device drivers...
[  1.401571 0 axdriver:156]   device model: static
[  1.404931 0 axdriver::bus::mmio:6] probing bus devices...
[  1.414115 0 virtio_drivers::transport:78] Device features: Features(CTRL_GUEST_OFFLOADS | MAC | GSO | MRG_RXBUF | STATUS | CTRL_VQ | CTRL_RX | CTRL_VLAN | CTRL_RX_EXTRA | GUEST_ANNOUNCE | CTL_MAC_ADDR | RING_INDIRECT_DESC | RING_EVENT_IDX)
[  1.427652 0 virtio_drivers::device::net::dev_raw:30] negotiated_features Features(MAC | STATUS | RING_INDIRECT_DESC | RING_EVENT_IDX)
[  1.437829 0 virtio_drivers::device::net::dev_raw:37] Got MAC=[52, 54, 00, 12, 34, 56], status=Status(LINK_UP)
[  1.462313 0 axalloc:118] expand heap memory: [0xffffffc08054c000, 0xffffffc08058c000)
[  1.480835 0 axdriver::bus::mmio:48] registered a new Net device at [PA:0x10008000, PA:0x10009000): "virtio-net"
[  1.489043 0 axdriver:163] number of NICs: 1
[  1.492562 0 axdriver:166]   NIC 0: "virtio-net", IRQ: 8
[  1.497607 0 axnet:42] Initialize network subsystem...
[  1.502271 0 axnet:45]   use NIC 0: "virtio-net", IRQ: 8
[  1.511428 0 axalloc:118] expand heap memory: [0xffffffc08058c000, 0xffffffc08060c000)
[  1.516916 0 axalloc:118] expand heap memory: [0xffffffc08060c000, 0xffffffc08070c000)
[  1.524530 0 axhal::platform::riscv64_qemu_virt::irq:80] register_handler: 8
[  1.530409 0 axhal::platform::riscv64_qemu_virt::irq:80] register_handler: 6
[  1.533774 0 axhal::platform::riscv64_qemu_virt::irq:80] register_handler: 5
[  1.536986 0 axhal::platform::riscv64_qemu_virt::irq:80] register_handler: 7
[  1.540323 0 axhal::platform::riscv64_qemu_virt::irq:80] register_handler: 77
[  1.544077 0 axhal::platform::riscv64_qemu_virt::irq:80] register_handler: 76
[  1.547504 0 axhal::platform::riscv64_qemu_virt::irq:80] register_handler: 78
[  1.551637 0 axnet::smoltcp_impl:347] created net interface "eth0":
[  1.555826 0 axnet::smoltcp_impl:348]   ether:    52-54-00-12-34-56
[  1.562115 0 axnet::smoltcp_impl:349]   ip:       10.0.2.15/24
[  1.568166 0 axnet::smoltcp_impl:350]   gateway:  10.0.2.2
[  1.572302 0 axnet::smoltcp_impl:351]   IRQ:      8
[  1.575778 0 axruntime:179] Initialize interrupt handlers...
[  1.578873 0 axhal::platform::riscv64_qemu_virt::irq:80] register_handler: 9223372036854775813
[  1.589495 0 axruntime:191] Primary CPU 0 init OK.
[  1.593850 0 axasync:144] Async runtime initialized
[  1.597849 0 async_server:50] Async HTTP Server
[  1.605160 0 axnet::smoltcp_impl::tcp:226] TCP socket listening on *:5555
[  1.611004 0 async_server:72] HTTP Server listening on http://0.0.0.0:5555/
[  1.617519 0 async_server:73] You can test with a web browser or: curl http://localhost:5555/
[  1.622311 0 async_server:83] Waiting for connection 1...
QEMU: Terminated
```

= Booting ArceOS on VisionFive 2

Boot procedure on RISC-V follows:

BootROM -> SPL -> SBI -> U-Boot -> OS

SPL (Secondary Program Loader) is a minimal bootloader that initializes the DDR
memory and basic hardware required to load the next stage.

And U-Boot, a more fully-featured bootloader, is responsible for loading the OS
kernel, setting up device drivers, and preparing the environment for the
operating system.

== Compile U-Boot and OpenSBI

My laptop is debian 13, these pacakges are needed to build U-Boot:

```sh
sudo apt install gnutls-dev openssl-dev swig gcc-risc64-linux-gnu
export CROSS_COMPILE=riscv64-linux-gnu-
```
Then just as stated in #link(
  "https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html",
)[VisionFive2 U-Boot Documentation], I cloned U-Boot and OpenSBI to build the
SPL image.

== Flash to SD card

Finally it comes to flashing. Package `disk` provides `sdisk` on debian. Just
install it. However, it's always harmless to backup:

```sh
dd if=/dev/sda1 of=tf-sda1-bk
```
```
4096+0 records in
4096+0 records out
2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.119711 s, 17.5 MB/s
```

Then creating the partitions and format the thrid one:

```sh
sgdisk --clear \
  --set-alignment=2 \
  --new=1:4096:8191 --change-name=1:spl --typecode=1:2E54B353-1271-4842-806F-E436D6AF6985 \
  --new=2:8192:16383 --change-name=2:uboot --typecode=2:BC13C2FF-59E6-4262-A352-B275FD6F7172 \
  --new=3:16384:1654784 --change-name=3:system --typecode=3:EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 \
  /dev/sda
```

```sh
mkfs.vfat -F32 /dev/sda3
```

Now program the SD card as #link(
  "https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html",
)[mentioned above]. Under ArceOS there is Makefile to generate kernel image:

```sh
apt install u-boot-tools
make A=examples/async_server ARCH=riscv64 PLATFORM=riscv64-starfive \
  LOG=debug NET=y SMP=4 BUS=mmio \
  FEATURES=net,driver-dwmac,bus-mmio \
  APP_FEATURES=default,starfive starfive
```

Copy all files to partition 3.

```sh
ls /mnt/
```

It should contain the following content.

```
arceos.itb uEnv.txt
```

== Todo

Two challenges remain:

After building SPL and U-Boot and flashing, SPL failed to read partition 2, and
U-Boot failed to start:

```
U-Boot SPL 2026.01-rc1-00156-g62b45e82bdbf (Nov 01 2025 - 12:42:20 +0800)
DDR version: dc2e84f0.
Trying to boot from MMC2
mmc_load_image_raw_sector: mmc block read error
Error: -38
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###
```

Restoring the backup SPL works:

```
U-Boot SPL 2021.10 (Sep 19 2024 - 15:43:53 +0800)
LPDDR4: 4G version: g8ad50857.
Trying to boot from MMC2

OpenSBI v1.2
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|___/_____|
        | |
        |_|

Platform Name             : StarFive VisionFive V2
Platform Features         : medeleg
Platform HART Count       : 5
Platform IPI Device       : aclint-mswi
Platform Timer Device     : aclint-mtimer @ 4000000Hz
Platform Console Device   : uart8250
Platform HSM Device       : ---
Platform PMU Device       : ---
Platform Reboot Device    : pm-reset
Platform Shutdown Device  : pm-reset
Platform Suspend Device   : ---
Firmware Base             : 0x40000000
Firmware Size             : 392 KB
Firmware RW Offset        : 0x40000
Runtime SBI Version       : 1.0

Domain0 Name              : root
Domain0 Boot HART         : 1
Domain0 HARTs             : 0*,1*,2*,3*,4*
Domain0 Region00          : 0x0000000002000000-0x000000000200ffff M: (I,R,W) S/U: ()
Domain0 Region01          : 0x0000000040000000-0x000000004003ffff M: (R,X) S/U: ()
Domain0 Region02          : 0x0000000040040000-0x000000004007ffff M: (R,W) S/U: ()
Domain0 Region03          : 0x0000000000000000-0xffffffffffffffff M: (R,W,X) S/U: (R,W,X)
Domain0 Next Address      : 0x0000000040200000
Domain0 Next Arg1         : 0x0000000042200000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes
Domain0 SysSuspend        : yes

Boot HART ID              : 1
Boot HART Domain          : root
Boot HART Priv Version    : v1.11
Boot HART Base ISA        : rv64imafdcbx
Boot HART ISA Extensions  : none
Boot HART PMP Count       : 8
Boot HART PMP Granularity : 4096
Boot HART PMP Address Bits: 34
Boot HART MHPM Count      : 2
Boot HART MIDELEG         : 0x0000000000000222
Boot HART MEDELEG         : 0x000000000000b109


U-Boot 2021.10 (Sep 19 2024 - 15:43:53 +0800)

CPU:   rv64imacu_zba_zbb
Model: StarFive VisionFive V2
DRAM:  4 GiB
MMC:   sdio0@16010000: 0, sdio1@16020000: 1
Loading Environment from SPIFlash... SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 KiB, tB
OK
StarFive EEPROM format v2

--------EEPROM INFO--------
Vendor : StarFive Technology Co., Ltd.
Product full SN: VF7110B1-2310-D004E000-00002814
data version: 0x2
PCB revision: 0xb2
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:5a:6a
Ethernet MAC1 address: 6c:cf:39:00:5a:6b
--------EEPROM INFO--------

In:    serial@10000000
Out:   serial@10000000
Err:   serial@10000000
Model: StarFive VisionFive V2
Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
bootmode sd device 1
Card did not respond to voltage select! : -110
Hit any key to stop autoboot:  0
64 bytes read in 5 ms (11.7 KiB/s)
## Warning: defaulting to text format
52853 bytes read in 9 ms (5.6 MiB/s)
52853 bytes written in 10 ms (5 MiB/s)
Retrieving file: /extlinux/extlinux.conf
Failed to load '/extlinux/extlinux.conf'
Error reading config file
StarFive #
```

Based on VisionFive 2 reference manual #link(
  "https://doc.rvspace.org/VisionFive2/PDF/VisionFive2_SW_TRM.pdf",
)[VisionFive2_SW_TRM.pdf] and #link(
  "https://doc.rvspace.org/VisionFive2/PDF/VisionFive2_QSG.pdf",
)[VisionFive2_QSG.pdf], I found that StarFive maintains their own forks of
U-Boot and OpenSBI. The next task is to investigate into their forks and find
the reason why the SPL cannot load U-Boot.

= Debugging

== Boot mode

After reading #link(
  "https://wiki.debian.org/InstallingDebianOn/StarFive/VisionFiveV2",
)[Installing Debian On StarFive VisionFiveV2], I found that I should switch the
boot method to *1-bit QSPI Nor Flash*.

Now U-Boot loads:

```
U-Boot SPL 2021.10 (Feb 28 2023 - 21:44:53 +0800)
DDR version: dc2e84f0.
Trying to boot from SPI

OpenSBI v1.2
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name             : StarFive VisionFive V2
Platform Features         : medeleg
Platform HART Count       : 5
Platform IPI Device       : aclint-mswi
Platform Timer Device     : aclint-mtimer @ 4000000Hz
Platform Console Device   : uart8250
Platform HSM Device       : jh7110-hsm
Platform PMU Device       : ---
Platform Reboot Device    : pm-reset
Platform Shutdown Device  : pm-reset
Firmware Base             : 0x40000000
Firmware Size             : 292 KB
Runtime SBI Version       : 1.0

Domain0 Name              : root
Domain0 Boot HART         : 1
Domain0 HARTs             : 0*,1*,2*,3*,4*
Domain0 Region00          : 0x0000000002000000-0x000000000200ffff (I)
Domain0 Region01          : 0x0000000040000000-0x000000004007ffff ()
Domain0 Region02          : 0x0000000000000000-0xffffffffffffffff (R,W,X)
Domain0 Next Address      : 0x0000000040200000
Domain0 Next Arg1         : 0x0000000042200000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes

Boot HART ID              : 1
Boot HART Domain          : root
Boot HART Priv Version    : v1.11
Boot HART Base ISA        : rv64imafdcbx
Boot HART ISA Extensions  : none
Boot HART PMP Count       : 8
Boot HART PMP Granularity : 4096
Boot HART PMP Address Bits: 34
Boot HART MHPM Count      : 2
Boot HART MIDELEG         : 0x0000000000000222
Boot HART MEDELEG         : 0x000000000000b109


U-Boot 2021.10 (Feb 28 2023 - 21:44:53 +0800), Build: jenkins-VF2_515_Branch_SDK_Release-31

CPU:   rv64imacu
Model: StarFive VisionFive V2
DRAM:  4 GiB
MMC:   sdio0@16010000: 0, sdio1@16020000: 1
Loading Environment from SPIFlash... SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 KiB, B
OK
StarFive EEPROM format v2

--------EEPROM INFO--------
Vendor : StarFive Technology Co., Ltd.
Product full SN: VF7110B1-2310-D004E000-00002814
data version: 0x2
PCB revision: 0xb2
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:5a:6a
Ethernet MAC1 address: 6c:cf:39:00:5a:6b
--------EEPROM INFO--------

In:    serial@10000000
Out:   serial@10000000
Err:   serial@10000000
Model: StarFive VisionFive V2
Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
switch to partitions #0, OK
mmc1 is current device
found device 1
bootmode flash device 1
Failed to load 'uEnv.txt'
Can't set block device
Hit any key to stop autoboot:  0
Failed to load '/uEnv.txt'
## Warning: defaulting to text format
Failed to load '/dtbs/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb'
libfdt fdt_check_header(): FDT_ERR_BADMAGIC
/dtbs/starfive: doesn't exist (-2)
** Unable to write file /dtbs/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb **
Retrieving file: /extlinux/extlinux.conf
Failed to load '/extlinux/extlinux.conf'
Error reading config file
StarFive #
```

So I have now verified that my SQL configuration and U-Boot firmware function
correctly.

== Debian image

I downloaded newest debian image release from #link(
  "https://rvspace.org/en/project/VisionFive2_Debian_User_Guide",
)[starfive debian user guide]. And then wrote the extracted image to SD card.

Finally, I booted into linux and could login to shell.

```
root@starfive:~# iperf3 -c 192.168.0.2
Connecting to host 192.168.0.2, port 5201
[  5] local 192.168.0.1 port 57704 connected to 192.168.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.01   sec  77.5 MBytes   642 Mbits/sec    0    228 KBytes
[  5]   1.01-2.02   sec  63.8 MBytes   531 Mbits/sec    0    281 KBytes
[  5]   2.02-3.01   sec  55.0 MBytes   466 Mbits/sec    0    297 KBytes
[  5]   3.01-4.00   sec   111 MBytes   941 Mbits/sec    0    365 KBytes
[  5]   4.00-5.00   sec   112 MBytes   940 Mbits/sec    0    365 KBytes
[  5]   5.00-6.00   sec   113 MBytes   955 Mbits/sec    0    382 KBytes
[  5]   6.00-7.00   sec   112 MBytes   939 Mbits/sec    0    382 KBytes
[  5]   7.00-8.00   sec   113 MBytes   944 Mbits/sec    0    382 KBytes
[  5]   8.00-9.00   sec   112 MBytes   942 Mbits/sec    0    382 KBytes
[  5]   9.00-10.00  sec   112 MBytes   938 Mbits/sec    0    382 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   982 MBytes   824 Mbits/sec    0             sender
[  5]   0.00-10.01  sec   980 MBytes   821 Mbits/sec                  receiver

iperf Done.
root@starfive:~# iperf3 -s
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
Accepted connection from 192.168.0.2, port 44764
[  5] local 192.168.0.1 port 5201 connected to 192.168.0.2 port 44780
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  91.8 MBytes   770 Mbits/sec
[  5]   1.00-2.00   sec   103 MBytes   865 Mbits/sec
[  5]   2.00-3.00   sec   101 MBytes   845 Mbits/sec
[  5]   3.00-4.00   sec   103 MBytes   866 Mbits/sec
[  5]   4.00-5.00   sec   104 MBytes   872 Mbits/sec
[  5]   5.00-6.00   sec   104 MBytes   875 Mbits/sec
[  5]   6.00-7.00   sec   105 MBytes   877 Mbits/sec
[  5]   7.00-8.00   sec   104 MBytes   875 Mbits/sec
[  5]   8.00-9.00   sec   111 MBytes   934 Mbits/sec
[  5]   9.00-10.00  sec   111 MBytes   934 Mbits/sec
[  5]  10.00-10.00  sec   288 KBytes   899 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.00  sec  1.01 GBytes   871 Mbits/sec                  receiver
```

And it's normal to observe that systemd remounted `/` as read-only during
shutdown.

```
[ 4000.792275] (sd-remount)[15359]: Remounting '/' read-only with options ''.
[ 4000.973043] EXT4-fs (mmcblk1p4): re-mounted a1242b99-a75f-46e6-92ab-64c5b3c7a316 ro. Quota mode: disab.
```

This happens because systemd-shutdown ensures all data is safely written to disk
before powering off or rebooting. It first sends `SIGTERM` and `SIGKILL` to
remaining processes, then synchronizes filesystems (`sync`), and finally
remounts the root filesystem `/` as read-only.
