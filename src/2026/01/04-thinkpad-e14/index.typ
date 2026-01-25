#import "/page.typ": conf
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

TL;DR: I got a ThinkPad laptop (E14 gen7, ultra 228V, 32G RAM, 512G SSD) for
4,900 CNY.

= Why ThinkPad

Before this, my daily laptop was an HP ZBook 15 G5 (8850H, 64GB RAM, dual M.2
slots plus another 2.5 HDD slot). I purchased this second-hand laptop in 2022
for around 4,600 CNY and had been using it for more than three years.

However, the HP ZBook is marketed as a mobile workstation, and it weighs 2.63
kg. Back then, I was too young and too naive to really know what kind of laptop
I needed. By no means am I implying that HP ZBooks are bad. They are extremely
easy to maintain: just flip a swtich and you can open its back panel to the
replace battery, SSD, or RAM. I installed 2x32G RAMs modules on it.

Now I've known better what laptop fits me:

It should be lightweight, ideally light enough to hold with one hand. Battery
life should be long enough to last a full workday: preferably until I can't go
any longer. Bonus points for ease of maintenance and portability, meaning I
don't need a workshop to replace the SSD (the Intel Lunar Lake processor has
memory wired to its SoC, which is a trade-off for power efficiency). An Ethernet
RJ45 port is a must, in case I need to connect to a server and start debugging
immediately. The graphics card is the least of my concerns, as I don't play
video games.

One might recommend the MacBook Air, but I'm not a fan of Apple in any form. In
fact, I'd be delighted if they sold their laptops as bare-metal machines,
stripped of macOS. The freedom to choose which software to install and the
ability to fully control the machine are more important to me, even at the cost
of reduced efficiency or performance. Additionally, macOS doesn't meet my needs
due to its limited network stack.

In the end, after surfing for 2 hours, I decided that it should be #link(
  "https://www.reddit.com/r/hardware/comments/1mqprou/thinkpad_e14_long_battery_life_edition/",
)[ThinkPad]. Luckliy, there are officially refurbished products (官翻机, items
returned within 7 days and resold by Lenovo agents), which saved me 1,000 CNY
more.

= Configuration

I tried #link("https://www.vixalien.com/blog/an-alpine-setup")[Alpine Linux].
However their `linux-lts` kernel seems to lack many of the compiling options for
modern lattops. No `CONFIG_HID_MUIITOUCH`, no `CONFIG_DRM_ACCEL` ... and my
GXTP5400:00 27C6:0F91 touchpad didn't work. So rather than compiling and
updating my own kernel image, I just use Arch.

Alpine is great, and I'm really into their package manager (apk) and miss its
packaging quality. Setting up an UKI kernel is as simple as it is on Arch. One
day I may give it another try.

Here's my consolidated choice:
- Kerenl: linux-zen
- Boot loader: systemd-boot
- Storage: btrfs on LUKS
- Kernel layout: UKI unsigned
- Shell: fish
- Editor: helix
- Desktop: #link(
    "https://drewdevault.com/2019/01/23/Why-I-use-old-hardware.html",
  )[sway]
- Terminal emulator: foot
- Container: podman
- Browser: firefox
- Pass manager: pass, pass-otp
- Email: neomutt, ibsync, msmtp
- RSS: newsboat
- AUR package downloader: paru

KDE? KDE is great of course. But using a lightweight desktop will help extend
battery life even longer.

= Why not Panther Lake

Panther Lake is expected to be released in Q2 2026. But as mentioned above,
performance is not my primary concern.

Who knows? I expect this laptop to last for the next 10 years. After all, there
are stories of old ThinkPad P series laptops still working after 10 years here
and there.

"640K ought to be enough for anybody."

It's astonishing how far we've come since then.

= User experience

The following statistics are measured under typical idle-to-light workloads of
one active sway instance, tens of firefox tabs open, several tmux sessions, and
one mpv instance streaming over a wiregurad tunnel with WiFi and bluetootch on:

```sh
sudo tlp-stat -b
```

```
--- TLP 1.9.0 --------------------------------------------

+++ Battery Care
Plugin: thinkpad
Supported features: charge thresholds, chargeonce, discharge, recalibrate
Driver usage:
* natacpi (thinkpad_acpi) = active (charge thresholds, force-discharge)
Parameter value ranges:
* START_CHARGE_THRESH_BAT0/1:  0(off)..96(default)..99
* STOP_CHARGE_THRESH_BAT0/1:   1..100(default)

+++ ThinkPad Battery Status: BAT0 (Main / Internal)
/sys/class/power_supply/BAT0/manufacturer                   = SMP
/sys/class/power_supply/BAT0/model_name                     = L24M3PG3
/sys/class/power_supply/BAT0/cycle_count                    =      7
/sys/class/power_supply/BAT0/energy_full_design             =  48000 [mWh]
/sys/class/power_supply/BAT0/energy_full                    =  48000 [mWh]
/sys/class/power_supply/BAT0/energy_now                     =  17330 [mWh]
/sys/class/power_supply/BAT0/power_now                      =   4990 [mW]
/sys/class/power_supply/BAT0/status                         = Discharging

/sys/class/power_supply/BAT0/charge_control_start_threshold =     75 [%]
/sys/class/power_supply/BAT0/charge_control_end_threshold   =     85 [%]
/sys/class/power_supply/BAT0/charge_behaviour               = [auto] inhibit-charge force-discharge

Charge                                                      =   36.1 [%]
Capacity                                                    =  100.0 [%]
```

And it's actually lower when it's idle, usually 2700 mW.
