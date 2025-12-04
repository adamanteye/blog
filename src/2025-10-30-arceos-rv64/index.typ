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

StarFive VisionFive 2 is a 4 core, 64 bit, RV64GC SBC, with highest freq to 1.5
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

#link(
  "https://doc-en.rvspace.org/VisionFive2/Boot_UG/JH7110_SDK/boot_process_memory_map.html",
)[Boot procedure] on RISC-V follows:

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

So I have now verified that my SPL and U-Boot firmware function correctly.

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

== ArceOS

To boot ArceOS, first initailize FAT filesystem at /dev/sda3, where the rootfs
lives. And then copy `arceos.itb` to `/`.

For u-boot to boot ArceOS automatically, write the following to `/uEnv.txt`:
```
bootcmd=fatload mmc 1:3 0xc0000000 arceos.itb; bootm 0xc0000000
```

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
64 bytes read in 5 ms (11.7 KiB/s)
Importing environment from mmc1 ...
Can't set block device
Hit any key to stop autoboot:  0
188495 bytes read in 14 ms (12.8 MiB/s)
## Loading kernel from FIT Image at c0000000 ...
   Using 'conf' configuration
   Trying 'kernel' kernel subimage
     Description:  Linux kernel for zCore-visionfive
     Type:         Kernel Image
     Compression:  gzip compressed
     Data Start:   0xc00000f0
     Data Size:    133889 Bytes = 130.8 KiB
     Architecture: RISC-V
     OS:           Linux
     Load Address: 0x40200000
     Entry Point:  0x40200000
   Verifying Hash Integrity ... OK
## Loading fdt from FIT Image at c0000000 ...
   Using 'conf' configuration
   Trying 'fdt' fdt subimage
     Description:  Flattened Device Tree blob for zCore-visionfive
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0xc0020cb8
     Data Size:    52853 Bytes = 51.6 KiB
     Architecture: RISC-V
   Verifying Hash Integrity ... OK
   Booting using the fdt blob at 0xc0020cb8
   Uncompressing Kernel Image
   Using Device Tree in place at 00000000c0020cb8, end 00000000c0030b2c

Starting kernel ...

clk u5_dw_i2c_clk_core already disabled
clk u5_dw_i2c_clk_apb already disabled

       d8888                            .d88888b.   .d8888b.
      d88888                           d88P" "Y88b d88P  Y88b
     d88P888                           888     888 Y88b.
    d88P 888 888d888  .d8888b  .d88b.  888     888  "Y888b.
   d88P  888 888P"   d88P"    d8P  Y8b 888     888     "Y88b.
  d88P   888 888     888      88888888 888     888       "888
 d8888888888 888     Y88b.    Y8b.     Y88b. .d88P Y88b  d88P
d88P     888 888      "Y8888P  "Y8888   "Y88888P"   "Y8888P"

arch = riscv64
platform = riscv64-starfive
target = riscv64gc-unknown-none-elf
build_mode = release
log_level = trace
smp = 1

[  4.915173 0 axruntime:133] Logging is enabled.
[  4.920892 0 axruntime:134] Primary CPU 1 started, dtb = 0xc0020cb8.
[  4.928432 0 axruntime:136] Found physcial memory regions:
[  4.935106 0 axruntime:138]   [PA:0x40200000, PA:0x4022e000) .text (READ | EXECUTE | RESERVED)
[  4.944899 0 axruntime:138]   [PA:0x4022e000, PA:0x4023d000) .rodata (READ | RESERVED)
[  4.953999 0 axruntime:138]   [PA:0x4023d000, PA:0x40240000) .data .tdata .tbss .percpu (READ | WRITE |)
[  4.965439 0 axruntime:138]   [PA:0x40240000, PA:0x40280000) boot stack (READ | WRITE | RESERVED)
[  4.975492 0 axruntime:138]   [PA:0x40280000, PA:0x40287000) .bss (READ | WRITE | RESERVED)
[  4.985025 0 axruntime:138]   [PA:0x40287000, PA:0x50000000) free memory (READ | WRITE | FREE)
[  4.994819 0 axruntime:138]   [PA:0x2000000, PA:0x200c000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.004959 0 axruntime:138]   [PA:0x2010000, PA:0x2011000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.015099 0 axruntime:138]   [PA:0xc000000, PA:0x10000000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.025325 0 axruntime:138]   [PA:0x10000000, PA:0x10010000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.035639 0 axruntime:138]   [PA:0x10010000, PA:0x10020000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.045952 0 axruntime:138]   [PA:0x10020000, PA:0x10030000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.056265 0 axruntime:138]   [PA:0x10030000, PA:0x10040000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.066579 0 axruntime:138]   [PA:0x10040000, PA:0x10050000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.076892 0 axruntime:138]   [PA:0x10050000, PA:0x10060000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.087205 0 axruntime:138]   [PA:0x13020000, PA:0x13030000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.097519 0 axruntime:138]   [PA:0x13030000, PA:0x13040000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.107832 0 axruntime:138]   [PA:0x13040000, PA:0x13050000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.118145 0 axruntime:138]   [PA:0x16010000, PA:0x16020000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.128459 0 axruntime:138]   [PA:0x16020000, PA:0x16030000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.138772 0 axruntime:138]   [PA:0x16030000, PA:0x16040000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.149085 0 axruntime:138]   [PA:0x16040000, PA:0x16050000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.159399 0 axruntime:138]   [PA:0x17000000, PA:0x17010000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.169712 0 axruntime:138]   [PA:0x17030000, PA:0x17040000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.180025 0 axruntime:138]   [PA:0x17040000, PA:0x17050000) mmio (READ | WRITE | DEVICE | RESERVED)
[  5.190339 0 axruntime:216] Initialize global memory allocator...
[  5.197619 0 axruntime:217]   use TLSF allocator.
[  5.203513 0 axalloc:212] initialize global allocator at: [0xffffffc040287000, 0xffffffc050000000)
[  5.213764 0 axmm:72] Initialize virtual memory management...
[  5.220590 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc040200000, VA:0xffffffc04022e000) -> [PE
[  5.234885 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc040200000, 0xffffffE
[  5.247723 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc04022e000, VA:0xffffffc04023d000) -> [PD
[  5.261146 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc04022e000, 0xffffffD
[  5.273107 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc04023d000, VA:0xffffffc040240000) -> [PE
[  5.287232 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc04023d000, 0xffffffE
[  5.299886 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc040240000, VA:0xffffffc040280000) -> [PE
[  5.314012 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc040240000, 0xffffffE
[  5.326670 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc040280000, VA:0xffffffc040287000) -> [PE
[  5.340792 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc040280000, 0xffffffE
[  5.353446 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc040287000, VA:0xffffffc050000000) -> [PE
[  5.367572 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc040287000, 0xffffffE
[  5.385604 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc002000000, VA:0xffffffc00200c000) -> [PE
[  5.400175 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc002000000, 0xffffffE
[  5.413618 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc002010000, VA:0xffffffc002011000) -> [PE
[  5.428342 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc002010000, 0xffffffE
[  5.441776 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc00c000000, VA:0xffffffc010000000) -> [PE
[  5.456595 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc00c000000, 0xffffffE
[  5.471404 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc010000000, VA:0xffffffc010010000) -> [PE
[  5.486148 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc010000000, 0xffffffE
[  5.499587 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc010010000, VA:0xffffffc010020000) -> [PE
[  5.514488 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc010010000, 0xffffffE
[  5.527923 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc010020000, VA:0xffffffc010030000) -> [PE
[  5.542828 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc010020000, 0xffffffE
[  5.556267 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc010030000, VA:0xffffffc010040000) -> [PE
[  5.571168 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc010030000, 0xffffffE
[  5.584603 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc010040000, VA:0xffffffc010050000) -> [PE
[  5.599508 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc010040000, 0xffffffE
[  5.612943 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc010050000, VA:0xffffffc010060000) -> [PE
[  5.627848 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc010050000, 0xffffffE
[  5.641283 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc013020000, VA:0xffffffc013030000) -> [PE
[  5.656188 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc013020000, 0xffffffE
[  5.669627 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc013030000, VA:0xffffffc013040000) -> [PE
[  5.684528 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc013030000, 0xffffffE
[  5.697963 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc013040000, VA:0xffffffc013050000) -> [PE
[  5.712868 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc013040000, 0xffffffE
[  5.726305 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc016010000, VA:0xffffffc016020000) -> [PE
[  5.741208 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc016010000, 0xffffffE
[  5.754647 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc016020000, VA:0xffffffc016030000) -> [PE
[  5.769548 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc016020000, 0xffffffE
[  5.782982 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc016030000, VA:0xffffffc016040000) -> [PE
[  5.797888 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc016030000, 0xffffffE
[  5.811323 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc016040000, VA:0xffffffc016050000) -> [PE
[  5.826228 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc016040000, 0xffffffE
[  5.839663 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc017000000, VA:0xffffffc017010000) -> [PE
[  5.854568 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc017000000, 0xffffffE
[  5.868007 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc017030000, VA:0xffffffc017040000) -> [PE
[  5.882908 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc017030000, 0xffffffE
[  5.896343 0 axmm::backend::linear:21] map_linear: [VA:0xffffffc017040000, VA:0xffffffc017050000) -> [PE
[  5.911248 0 page_table_multiarch::bits64:171] map_region(PA:0x4028f000): [0xffffffc017040000, 0xffffffE
[  5.924685 0 axmm:75] kernel address space init OK: AddrSpace {
    va_range: VA:0xffffffc000000000..VA:0xfffffffffffff000,
    page_table_root: PA:0x4028f000,
    areas: [
        MemoryArea {
            va_range: VA:0xffffffc002000000..VA:0xffffffc00200c000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc002010000..VA:0xffffffc002011000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc00c000000..VA:0xffffffc010000000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc010000000..VA:0xffffffc010010000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc010010000..VA:0xffffffc010020000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc010020000..VA:0xffffffc010030000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc010030000..VA:0xffffffc010040000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc010040000..VA:0xffffffc010050000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc010050000..VA:0xffffffc010060000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc013020000..VA:0xffffffc013030000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc013030000..VA:0xffffffc013040000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc013040000..VA:0xffffffc013050000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc016010000..VA:0xffffffc016020000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc016020000..VA:0xffffffc016030000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc016030000..VA:0xffffffc016040000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc016040000..VA:0xffffffc016050000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc017000000..VA:0xffffffc017010000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc017030000..VA:0xffffffc017040000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc017040000..VA:0xffffffc017050000,
            flags: READ | WRITE | DEVICE,
        },
        MemoryArea {
            va_range: VA:0xffffffc040200000..VA:0xffffffc04022e000,
            flags: READ | EXECUTE,
        },
        MemoryArea {
            va_range: VA:0xffffffc04022e000..VA:0xffffffc04023d000,
            flags: READ,
        },
        MemoryArea {
            va_range: VA:0xffffffc04023d000..VA:0xffffffc040240000,
            flags: READ | WRITE,
        },
        MemoryArea {
            va_range: VA:0xffffffc040240000..VA:0xffffffc040280000,
            flags: READ | WRITE,
        },
        MemoryArea {
            va_range: VA:0xffffffc040280000..VA:0xffffffc040287000,
            flags: READ | WRITE,
        },
        MemoryArea {
            va_range: VA:0xffffffc040287000..VA:0xffffffc050000000,
            flags: READ | WRITE,
        },
    ],
}
[  6.253582 0 axhal::arch::riscv:63] set page table root: PA:0x4023d000 => PA:0x4028f000
[  6.262769 0 axruntime:153] Initialize platform devices...
[  6.269442 0 axruntime:164] Initialize interrupt handlers...
[  6.276288 0 axruntime:243] init_interrupt
[  6.281575 0 axruntime:250] PERIODIC_INTERVAL_NANOS: 10000000, NANOS_PER_SEC: 1000000000, TICKS_PER_SEC0
[  6.292581 0 axhal::platform::riscv64_starfive::irq:81] register_handler: 9223372036854775813
[  6.302290 0 axruntime:306] priority of IRQ 5: 0x0
[  6.308268 0 axruntime:306] priority of IRQ 6: 0x0
[  6.314250 0 axruntime:306] priority of IRQ 7: 0x0
[  6.320228 0 axruntime:306] priority of IRQ 76: 0x0
[  6.326296 0 axruntime:306] priority of IRQ 77: 0x0
[  6.332363 0 axruntime:306] priority of IRQ 78: 0x0
[  6.338428 0 axruntime:310] plic enable_reg: 0x92b5a2a8419d6e7b7bbad5be127ea54c
[  6.346922 0 axruntime:313] plic pending_reg: 0x4000000000018
[  6.353856 0 axruntime:316] sie: 0x222
[  6.358795 0 axruntime:319] sip: 0x0
[  6.363562 0 axruntime:322] sstatus: Sstatus { bits: 8000000200006022 }
[  6.371361 0 axruntime:326] uart DLH/IER: 0x0
[  6.376910 0 axruntime:330] uart DLH/IER: 0x1
[  6.382456 0 axruntime:292] enable_irqs
[  6.387481 0 axdriver:155] Initialize device drivers...
[  6.393896 0 axdriver:156]   device model: static
[  6.399788 0 axdriver::bus::mmio:6] probing bus devices...
[  6.406463 0 axdriver::bus::mmio:10] skipping GPIO MMIO region
[  6.413482 0 axdriver::drivers:193] DWMAC tutorial device found at 0x16040000 (GMAC1)
[  6.422496 0 axdriver_net::dwmac:403] 🚀 Initializing DWMAC ethernet driver (tutorial version)
[  6.432462 0 axdriver::dwmac:87] 🔧 StarFive platform configuration (tutorial + PAC verification mode)
[  6.443123 0 axdriver::dwmac:117] 🔧 Clock GMAC5 AXI64 TX is set correctly: 0x81000000
[  6.452397 0 axdriver::dwmac:117] 🔧 Clock GMAC5 AXI is set correctly: 0x80000000
[  6.461235 0 axdriver::dwmac:117] 🔧 Clock GMAC5 AHB is set correctly: 0x80000000
[  6.470076 0 axdriver::dwmac:117] 🔧 Clock GMAC0 PTP is set correctly: 0x8000000a
[  6.478917 0 axdriver::dwmac:117] 🔧 Clock GMAC5 AXI64 TX is set correctly: 0x81000000
[  6.488190 0 axdriver::dwmac:117] 🔧 Clock GMAC5 AXI64 TXI is set correctly: 0x40000000
[  6.497550 0 axdriver::dwmac:117] 🔧 Clock GMAC0 GTX is set correctly: 0x80000008
[  6.506390 0 axdriver::dwmac:117] 🔧 Clock GMAC0 GTXCLK is set correctly: 0x80000020
[  6.515490 0 axdriver::dwmac:117] 🔧 Clock GMAC5 AXI64 AXI is set correctly: 0x80000000
[  6.524850 0 axdriver::dwmac:117] 🔧 Clock GMAC5 AXI64 AHB is set correctly: 0x80000000
[  6.534210 0 axdriver::dwmac:117] 🔧 Clock GMAC5 AXI64 PTP is set correctly: 0x8000000a
[  6.543569 0 axdriver::dwmac:117] 🔧 Clock GMAC1 RMII RTX is set correctly: 0x2
[  6.552235 0 axdriver::dwmac:117] 🔧 Clock GMAC5 AXI64 TX is set correctly: 0x81000000
[  6.561510 0 axdriver::dwmac:117] 🔧 Clock GMAC5 AXI64 TXI is set correctly: 0x40000000
[  6.570870 0 axdriver::dwmac:117] 🔧 Clock GMAC1 GTXCLK is set correctly: 0x80000020
[  7.379974 0 axdriver::dwmac:338]    📊 Current hardware status (read-only, preserved from U-Boot):
[  7.390213 0 axdriver::dwmac:361]    🔍 Clock register readings (may not reflect actual hardware stat  :
[  7.401046 0 axdriver::dwmac:367]      GMAC5 AXI64 AXI: ✅ enabled (register view)
[  7.409885 0 axdriver::dwmac:375]      GMAC5 AXI64 PTP: ✅ enabled (register view)
[  7.418725 0 axdriver::dwmac:383]      GMAC0 GTX: ✅ enabled (register view)
[  7.427045 0 axdriver::dwmac:392]    💡 Note: Clock registers may show 'disabled' even when hardware   s
[  7.438052 0 axdriver::dwmac:393]    💡 U-Boot may use different initialization sequence than Linux d  t
[  7.449752 0 axdriver::dwmac:396]    💡 The real test is whether networking actually works!
[  7.459459 0 axdriver::dwmac:398]    🔧 Reset status - Soft reset selector 2: 0xffe5efc0 (preserved)
[  7.469946 0 axdriver::dwmac:403]    🔧 Reset status - AON reset selector: 0xe0 (preserved)
[  7.479652 0 axdriver::dwmac:408]    🔧 Clock config - GMAC1 GTX: 0x8 (preserved)
[  7.488492 0 axdriver::dwmac:413]    🔧 Clock config - GMAC1 RMII RTX: 0x2 (preserved)
[  7.497766 0 axdriver::dwmac:418]    🔧 Clock config - GMAC1 GTX: 0x8 (preserved)
[  7.506606 0 axdriver::dwmac:423]    🔧 Clock config - CPU Root: 0x1000000 (preserved)
[  7.515879 0 axdriver::dwmac:427]    🔧 Clock config - CPU Core: 0x1 (preserved)
[  7.524632 0 axdriver::dwmac:431]    🔧 Clock config - CPU Bus: 0x2 (preserved)
[  7.533298 0 axdriver::dwmac:100] ✅ Platform configuration preserved - ready for DWMAC operation
[  7.543439 0 axdriver::dwmac:101] 💡 TIP: U-Boot has already initialized everything - just trust it!
[  7.553929 0 page_table_multiarch::bits64:275] protect_region(PA:0x4028f000) [0xffffffc040336000, 0xfffD
[  7.567795 0 axdriver_net::dwmac:183] 🔍 Descriptor ring allocated at bus: 0x40336000, virt: 0xffffff  0
[  7.579344 0 page_table_multiarch::bits64:275] protect_region(PA:0x4028f000) [0xffffffc040356000, 0xfffD
[  7.593236 0 axalloc:118] expand heap memory: [0xffffffc040996000, 0xffffffc04099e000)
[  7.602223 0 axalloc:118] expand heap memory: [0xffffffc04099e000, 0xffffffc0409ae000)
[  7.611348 0 page_table_multiarch::bits64:275] protect_region(PA:0x4028f000) [0xffffffc0409ae000, 0xfffD
[  7.625168 0 axdriver_net::dwmac:183] 🔍 Descriptor ring allocated at bus: 0x409ae000, virt: 0xffffff  0
[  7.636717 0 page_table_multiarch::bits64:275] protect_region(PA:0x4028f000) [0xffffffc0409ce000, 0xfffD
[  7.650622 0 axalloc:118] expand heap memory: [0xffffffc04100e000, 0xffffffc04102e000)
[  7.659615 0 axdriver_net::dwmac:592] 🔄 Resetting DMA Mode
[  7.666506 0 axdriver_net::dwmac:1049]     🔍                     DMA BUS_MODE(0x1000): 0x00000000
[  7.687820 0 axdriver_net::dwmac:610] ✅ DMA Mode reset complete
[  7.694937 0 axdriver_net::dwmac:861] 🔧 Initializing PHY (basic)
[  7.752398 0 axdriver_net::dwmac:874] 🔍 PHY ID: 0x4f51e91b
[  9.979366 0 axdriver_net::dwmac:960] 🔍 PHY EXT_CHIP_CONFIG: 0x8020
[ 10.046924 0 axdriver_net::dwmac:992] 🔍 PHY EXT_RGMII_CONFIG1: 0x48f0
[ 10.054647 0 axdriver_net::dwmac:615] 🔧 Setting clock frequency to 124 MHz
[ 10.062969 0 axdriver_net::dwmac:1049]     🔍               MAC US_TIC_COUNTER(0x00dc): 0x0000007c
[ 12.113459 0 axdriver_net::dwmac:798] 🔧 Initializing MTL
[ 12.120057 0 axdriver_net::dwmac:1049]     🔍          MTL TXQ0_OPERATION_MODE(0x0d00): 0x0007000a
[ 12.130371 0 axdriver_net::dwmac:1049]     🔍          MTL TXQ0_OPERATION_MODE(0x0d00): 0x0007000a
[ 12.140684 0 axdriver_net::dwmac:1049]     🔍          MTL TXQ0_QUANTUM_WEIGHT(0x0d18): 0x00000000
[ 12.150998 0 axdriver_net::dwmac:1049]     🔍          MTL RXQ0_OPERATION_MODE(0x0d30): 0x00700020
[ 12.161311 0 axdriver_net::dwmac:1049]     🔍          MTL TXQ0_OPERATION_MODE(0x0d00): 0x0007000a
[ 12.171624 0 axdriver_net::dwmac:1049]     🔍          MTL RXQ0_OPERATION_MODE(0x0d30): 0x00700020
[ 12.181937 0 axdriver_net::dwmac:827] 🔧 Configuring flow control
[ 12.189391 0 axdriver_net::dwmac:1049]     🔍                    MAC RXQ_CTRL0(0x00a0): 0x00000000
[ 12.199704 0 axdriver_net::dwmac:1049]     🔍                    MAC RXQ_CTRL1(0x00a4): 0x00000000
[ 12.210018 0 axdriver_net::dwmac:1049]     🔍                 MAC FRAME_FILTER(0x0008): 0x00000404
[ 12.220331 0 axdriver_net::dwmac:1049]     🔍              MAC Q0_TX_FLOW_CTRL(0x0070): 0xffff0000
[ 12.230644 0 axdriver_net::dwmac:1049]     🔍                MAC TXQ_PRTY_MAP0(0x0098): 0x00000000
[ 12.240958 0 axdriver_net::dwmac:1049]     🔍                    MAC RXQ_CTRL2(0x00a8): 0x00000000
[ 12.251271 0 axdriver_net::dwmac:1049]     🔍              MAC Q0_TX_FLOW_CTRL(0x0070): 0xffff0002
[ 12.261584 0 axdriver_net::dwmac:1049]     🔍                 MAC RX_FLOW_CTRL(0x0090): 0x00000001
[ 12.271898 0 axdriver_net::dwmac:1049]     🔍                       MAC CONFIG(0x0000): 0x00000000
[ 12.282210 0 axdriver_net::dwmac:746] 🔧 Setting MAC address
[ 12.289231 0 axdriver_net::dwmac:769] 🔧 Stopping DMA
[ 12.295645 0 axdriver_net::dwmac:1049]     🔍                 DMA CHAN_TX_CTRL(0x1104): 0x00080010
[ 12.305957 0 axdriver_net::dwmac:1049]     🔍                 DMA CHAN_RX_CTRL(0x1108): 0x00080c80
[ 12.316271 0 axdriver_net::dwmac:1049]     🔍               DMA CHAN_BASE_ADDR(0x1100): 0x00190000
[ 12.326584 0 axdriver_net::dwmac:1049]     🔍                 DMA SYS_BUS_MODE(0x1004): 0x030308f1
[ 12.336898 0 axdriver_net::dwmac:1049]     🔍                     DMA BUS_MODE(0x1000): 0x00000000
[ 12.347211 0 axdriver_net::dwmac:645] 🔧 Setting up descriptor rings
[ 12.388702 0 axdriver_net::dwmac:1049]     🔍            DMA CHAN_TX_BASE_ADDR(0x1114): 0x40336000
[ 12.398855 0 axdriver_net::dwmac:1049]     🔍            DMA CHAN_RX_BASE_ADDR(0x111c): 0x409ae000
[ 12.409169 0 axdriver_net::dwmac:1049]     🔍                 DMA CHAN_TX_CTRL(0x1104): 0x00080011
[ 12.419482 0 axdriver_net::dwmac:1049]     🔍                 DMA CHAN_RX_CTRL(0x1108): 0x00080c81
[ 12.429795 0 axdriver_net::dwmac:691] ✅ Descriptor rings ready
[ 12.436988 0 axdriver_net::dwmac:788] 🚀 Starting DMA
[ 12.443400 0 axdriver_net::dwmac:713] 🔧 Configuring MAC
[ 12.450075 0 axdriver_net::dwmac:1049]     🔍                 MAC FRAME_FILTER(0x0008): 0x00000404
[ 12.460388 0 axdriver_net::dwmac:1049]     🔍                       MAC CONFIG(0x0000): 0x0030e003
[ 12.470701 0 axdriver_net::dwmac:698] 🔧 Updating RX end address to 0x409cdfc0
[ 12.479281 0 axdriver_net::dwmac:1049]     🔍             DMA CHAN_RX_END_ADDR(0x1128): 0x409cdfc0
[ 12.489595 0 axdriver_net::dwmac:1049]     🔍             DMA CHAN_RX_END_ADDR(0x1128): 0x409cdfc0
[ 12.499908 0 axdriver_net::dwmac:739] 🔧 MAC enabled
[ 12.506235 0 axdriver_net::dwmac:1049]     🔍                      MAC VERSION(0x0110): 0x00004152
[ 12.516548 0 axdriver_net::dwmac:539] 🔧 Enabling DMA channel 0 interrupts...
[ 12.525041 0 axdriver_net::dwmac:1049]     🔍                  DMA CHAN_STATUS(0x1160): 0x00000000
[ 12.535355 0 axdriver_net::dwmac:1049]     🔍             DMA CHAN_INTR_ENABLE(0x1134): 0x00000000
[ 12.545668 0 axdriver_net::dwmac:1049]     🔍             DMA CHAN_INTR_ENABLE(0x1134): 0x0000d041
[ 12.555981 0 axdriver_net::dwmac:554] 🔧 Enabling GMAC interrupts...
[ 12.563694 0 axdriver_net::dwmac:1049]     🔍             MAC INTERRUPT_STATUS(0x00b0): 0x00040000
[ 12.574009 0 axdriver_net::dwmac:1049]     🔍             MAC INTERRUPT_ENABLE(0x00b4): 0x00000001
[ 12.584321 0 axdriver_net::dwmac:1049]     🔍             MAC INTERRUPT_STATUS(0x00b0): 0x00000000
[ 12.594635 0 axdriver_net::dwmac:1049]     🔍                       DMA STATUS(0x1008): 0x00000000
[ 12.604948 0 axdriver_net::dwmac:533] ✅ DWMAC initialization complete
[ 12.612749 0 axdriver::drivers:200] ✅ DWMAC tutorial device (GMAC1) initialized successfully!
[ 12.622629 0 axdriver::bus::mmio:25] registered a new Net device at [PA:0x16040000, PA:0x16050000): "dw"
[ 12.633895 0 axdriver:163] number of NICs: 1
[ 12.639355 0 axdriver:166]   NIC 0: "dwmac-5.2", IRQ: 78
[ 12.645856 0 axnet:42] Initialize network subsystem...
[ 12.652180 0 axnet:45]   use NIC 0: "dwmac-5.2", IRQ: 78
[ 12.658695 0 axalloc:118] expand heap memory: [0xffffffc04102e000, 0xffffffc0410ae000)
[ 12.667799 0 axalloc:118] expand heap memory: [0xffffffc0410ae000, 0xffffffc0411ae000)
[ 12.677358 0 axnet::smoltcp_impl:334] created net interface "eth0":
[ 12.684649 0 axnet::smoltcp_impl:335]   ether:    35-5d-00-39-cf-6c
[ 12.692104 0 axnet::smoltcp_impl:336]   ip:       192.168.1.114/24
[ 12.699470 0 axnet::smoltcp_impl:337]   gateway:  192.168.1.1
[ 12.706402 0 axnet::smoltcp_impl:338]   IRQ:      78
[ 12.712557 0 axhal::platform::riscv64_starfive::irq:81] register_handler: 7
[ 12.720704 0 axhal::platform::riscv64_starfive::irq:81] register_handler: 78
[ 12.728938 0 axruntime:194] Primary CPU 1 init OK.
[ 12.734916 0 axasync:144] Async runtime initialized
[ 12.740984 0 async_server:50] Async HTTP Server
[ 12.746705 0 axnet::smoltcp_impl::tcp:226] TCP socket listening on *:5555
[ 12.754677 0 async_server:72] HTTP Server listening on http://0.0.0.0:5555/
[ 12.762823 0 async_server:73] You can test with a web browser or: curl http://localhost:5555/
[ 12.772530 0 async_server:83] Waiting for connection 1...
```

However, ArceOS does not respond my TCP request from L2 peer directly connected
via ethernet, even when its MAC address is already present in my ARP table:

```
root@monika ~# curl -v http://192.168.1.114:5555/
*   Trying 192.168.1.114:5555...
root@monika ~# ip neighbour replace 192.168.1.114 lladdr 35:5d:00:39:cf:6c dev enp0s31f6 nud permanent
root@monika ~# curl -v http://192.168.1.114:5555/
*   Trying 192.168.1.114:5555...
```

```
# arceos kernel log
[ 11.373752 0 axnet::smoltcp_impl:334] created net interface "eth0":
[ 11.381043 0 axnet::smoltcp_impl:335]   ether:    35-5d-00-39-cf-6c
[ 11.388498 0 axnet::smoltcp_impl:336]   ip:       192.168.1.114/24
[ 11.395865 0 axnet::smoltcp_impl:337]   gateway:  192.168.1.1
[ 11.402796 0 axnet::smoltcp_impl:338]   IRQ:      78
# tcpdump
ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 192.168.1.114 tell 192.168.1.2, length 28
ARP, Ethernet (len 6), IPv4 (len 4), Request who-has 192.168.1.114 tell 192.168.1.2, length 28
IP (tos 0x0, ttl 64, id 22542, offset 0, flags [DF], proto TCP (6), length 60)
    192.168.1.2.52820 > 192.168.1.114.5555: Flags [S], cksum 0x83f3 (incorrect -> 0x13f5), seq 1660752033, win 64240, options [mss 1460,sackOK,TS val 3798039370 ecr 0,nop,wscale 10], length 0
IP (tos 0x0, ttl 64, id 22543, offset 0, flags [DF], proto TCP (6), length 60)
    192.168.1.2.52820 > 192.168.1.114.5555: Flags [S], cksum 0x83f3 (incorrect -> 0x0ff5), seq 1660752033, win 64240, options [mss 1460,sackOK,TS val 3798040394 ecr 0,nop,wscale 10], length 0
```
