#!/usr/bin/env python3
import os
import struct
import subprocess
import tempfile
import math
from colour import Color

BARS_NUMBER = 10
# OUTPUT_BIT_FORMAT = "8bit"
OUTPUT_BIT_FORMAT = "16bit"
# RAW_TARGET = "/tmp/cava.fifo"
RAW_TARGET = "/dev/stdout"

ENABLE_COLOURS = True

conpat = """
[general]
bars = %d
; autosens = 0
; sensitivity = 200
[output]
method = raw
raw_target = %s
bit_format = %s
channels = mono
"""

config = conpat % (BARS_NUMBER, RAW_TARGET, OUTPUT_BIT_FORMAT)
bytetype, bytesize, bytenorm = (
    ("H", 2, 65535) if OUTPUT_BIT_FORMAT == "16bit" else ("B", 1, 255)
)

chars = "▁▂▃▄▅▆▇█"
# More colours than chars makes it look smoother
color_count = 50
colors = list(Color("#94e2d5").range_to(Color("#f38ba8"), color_count))


def run():
    with tempfile.NamedTemporaryFile() as config_file:
        config_file.write(config.encode())
        config_file.flush()

        process = subprocess.Popen(
            ["cava", "-p", config_file.name], stdout=subprocess.PIPE
        )
        chunk = bytesize * BARS_NUMBER
        fmt = bytetype * BARS_NUMBER

        if RAW_TARGET != "/dev/stdout":
            if not os.path.exists(RAW_TARGET):
                os.mkfifo(RAW_TARGET)
            source = open(RAW_TARGET, "rb")
        else:
            source = process.stdout

        while True:
            data = source.read(chunk)
            if len(data) < chunk:
                break
            # sample = [i for i in struct.unpack(fmt, data)]  # raw values without norming
            sample = [i / bytenorm for i in struct.unpack(fmt, data)]
            outstr = ""
            for f in sample:
                index = min(math.floor(len(chars) * f), len(chars) - 1)
                col_index = min(math.floor(color_count * f), color_count - 1)
                inner_char = chars[index]
                if not ENABLE_COLOURS:
                    outstr += inner_char
                    continue
                # Wrap each char in correct colour with pango
                outstr += f"<span foreground='{colors[col_index]}'>{inner_char}</span>"

            print(outstr, flush=True)


if __name__ == "__main__":
    run()
