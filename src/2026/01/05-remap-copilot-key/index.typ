#import "/page.typ": conf
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

TL;DR:

```sh
sudo systemctl enable --now keyd
```

With the following configuration:

```
# /etc/keyd/default.conf
[ids]
*
[meta]
leftshift = layer(copilot)
[copilot]
f23 = capslock
```

= Observation

`ESC` is usually located in an awkward position for the fingers to reach while
typing. Many people prefer the idea of mapping `CAPSLOCK` to `ESC`.

New laptops manufactured in 2025 introduce the so-called _Copilot key_, which
turns out to be a perfect replacement for `CAPSLOCK`.

To inspect your input events, you can use libinput:

```sh
sudo libinput debug-events --show-keycodes
```

```
event16  KEYBOARD_KEY                 +1.862s	KEY_LEFTMETA (125) pressed
event16  KEYBOARD_KEY                 +1.864s	KEY_LEFTSHIFT (42) pressed
event16  KEYBOARD_KEY                 +1.867s	KEY_F23 (193) pressed
event16  KEYBOARD_KEY                 +1.934s	KEY_F23 (193) released
event16  KEYBOARD_KEY                 +1.937s	KEY_LEFTSHIFT (42) released
event16  KEYBOARD_KEY                 +1.942s	KEY_LEFTMETA (125) released
```

That is all. The Copilot key is merely a composite of three keys. Once
identified, it can be remapped using #link(
  "https://github.com/rvaiya/keyd",
)[keyd].
