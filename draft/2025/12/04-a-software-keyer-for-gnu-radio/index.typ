#import "../../page.typ": conf
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

= GNU Radio

#link("https://youtu.be/enLbgn1qBS4")[Intro to GNU Radio Companion]

```python
"""
Keyboard CW keyer block
Outputs 1.0 when SPACE is pressed, else 0.0
"""

import numpy as np
from gnuradio import gr
from pynput import keyboard


class blk(gr.sync_block):
    """
    Keyboard CW Keyer
    """

    def __init__(self):
        gr.sync_block.__init__(
            self,
            name="Keyboard CW Keyer",
            in_sig=None,
            out_sig=[np.float32],
        )
        self.state = 0.0
        listener = keyboard.Listener(
            on_press=self.on_press, on_release=self.on_release
        )
        listener.daemon = True
        listener.start()

    def on_press(self, key):
        if key == keyboard.Key.space:
            self.state = 1.0

    def on_release(self, key):
        if key == keyboard.Key.space:
            self.state = 0.0

    def work(self, input_items, output_items):
        out = output_items[0]
        out[:] = self.state
        return len(out)
```
