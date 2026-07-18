pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root

    property string variant: "mocha" // "latte" | "frappe" | "macchiato" | "mocha"

    readonly property QtObject latte: QtObject {
        readonly property color rosewater: "#dc8a78"
        readonly property color flamingo: "#dd7878"
        readonly property color pink: "#ea76cb"
        readonly property color mauve: "#8839ef"
        readonly property color red: "#d20f39"
        readonly property color maroon: "#e64553"
        readonly property color peach: "#fe640b"
        readonly property color yellow: "#df8e1d"
        readonly property color green: "#40a02b"
        readonly property color teal: "#179299"
        readonly property color sky: "#04a5e5"
        readonly property color sapphire: "#209fb5"
        readonly property color blue: "#1e66f5"
        readonly property color lavender: "#7287fd"
        readonly property color text: "#4c4f69"
        readonly property color subtext1: "#5c5f77"
        readonly property color subtext0: "#6c6f85"
        readonly property color overlay2: "#7c7f93"
        readonly property color overlay1: "#8c8fa1"
        readonly property color overlay0: "#9ca0b0"
        readonly property color surface2: "#acb0be"
        readonly property color surface1: "#bcc0cc"
        readonly property color surface0: "#ccd0da"
        readonly property color base: "#eff1f5"
        readonly property color mantle: "#e6e9ef"
        readonly property color crust: "#dce0e8"
    }

    readonly property QtObject frappe: QtObject {
        readonly property color rosewater: "#f2d5cf"
        readonly property color flamingo: "#eebebe"
        readonly property color pink: "#f4b8e4"
        readonly property color mauve: "#ca9ee6"
        readonly property color red: "#e78284"
        readonly property color maroon: "#ea999c"
        readonly property color peach: "#ef9f76"
        readonly property color yellow: "#e5c890"
        readonly property color green: "#a6d189"
        readonly property color teal: "#81c8be"
        readonly property color sky: "#99d1db"
        readonly property color sapphire: "#85c1dc"
        readonly property color blue: "#8caaee"
        readonly property color lavender: "#babbf1"
        readonly property color text: "#c6d0f5"
        readonly property color subtext1: "#b5bfe2"
        readonly property color subtext0: "#a5adce"
        readonly property color overlay2: "#949cbb"
        readonly property color overlay1: "#838ba7"
        readonly property color overlay0: "#737994"
        readonly property color surface2: "#626880"
        readonly property color surface1: "#51576d"
        readonly property color surface0: "#414559"
        readonly property color base: "#303446"
        readonly property color mantle: "#292c3c"
        readonly property color crust: "#232634"
    }

    readonly property QtObject macchiato: QtObject {
        readonly property color rosewater: "#f4dbd6"
        readonly property color flamingo: "#f0c6c6"
        readonly property color pink: "#f5bde6"
        readonly property color mauve: "#c6a0f6"
        readonly property color red: "#ed8796"
        readonly property color maroon: "#ee99a0"
        readonly property color peach: "#f5a97f"
        readonly property color yellow: "#eed49f"
        readonly property color green: "#a6da95"
        readonly property color teal: "#8bd5ca"
        readonly property color sky: "#91d7e3"
        readonly property color sapphire: "#7dc4e4"
        readonly property color blue: "#8aadf4"
        readonly property color lavender: "#b7bdf8"
        readonly property color text: "#cad3f5"
        readonly property color subtext1: "#b8c0e0"
        readonly property color subtext0: "#a5adcb"
        readonly property color overlay2: "#939ab7"
        readonly property color overlay1: "#8087a2"
        readonly property color overlay0: "#6e738d"
        readonly property color surface2: "#5b6078"
        readonly property color surface1: "#494d64"
        readonly property color surface0: "#363a4f"
        readonly property color base: "#24273a"
        readonly property color mantle: "#1e2030"
        readonly property color crust: "#181926"
    }

    readonly property QtObject mocha: QtObject {
        readonly property color rosewater: "#f5e0dc"
        readonly property color flamingo: "#f2cdcd"
        readonly property color pink: "#f5c2e7"
        readonly property color mauve: "#cba6f7"
        readonly property color red: "#f38ba8"
        readonly property color maroon: "#eba0ac"
        readonly property color peach: "#fab387"
        readonly property color yellow: "#f9e2af"
        readonly property color green: "#a6e3a1"
        readonly property color teal: "#94e2d5"
        readonly property color sky: "#89dceb"
        readonly property color sapphire: "#74c7ec"
        readonly property color blue: "#89b4fa"
        readonly property color lavender: "#b4befe"
        readonly property color text: "#cdd6f4"
        readonly property color subtext1: "#bac2de"
        readonly property color subtext0: "#a6adc8"
        readonly property color overlay2: "#9399b2"
        readonly property color overlay1: "#7f849c"
        readonly property color overlay0: "#6c7086"
        readonly property color surface2: "#585b70"
        readonly property color surface1: "#45475a"
        readonly property color surface0: "#313244"
        readonly property color base: "#1e1e2e"
        readonly property color mantle: "#181825"
        readonly property color crust: "#11111b"
    }

    readonly property QtObject palette: variant === "latte" ? latte
        : variant === "frappe" ? frappe
        : variant === "macchiato" ? macchiato
        : mocha

    readonly property color rosewater: palette.rosewater
    readonly property color flamingo: palette.flamingo
    readonly property color pink: palette.pink
    readonly property color mauve: palette.mauve
    readonly property color red: palette.red
    readonly property color maroon: palette.maroon
    readonly property color peach: palette.peach
    readonly property color yellow: palette.yellow
    readonly property color green: palette.green
    readonly property color teal: palette.teal
    readonly property color sky: palette.sky
    readonly property color sapphire: palette.sapphire
    readonly property color blue: palette.blue
    readonly property color lavender: palette.lavender
    readonly property color text: palette.text
    readonly property color subtext1: palette.subtext1
    readonly property color subtext0: palette.subtext0
    readonly property color overlay2: palette.overlay2
    readonly property color overlay1: palette.overlay1
    readonly property color overlay0: palette.overlay0
    readonly property color surface2: palette.surface2
    readonly property color surface1: palette.surface1
    readonly property color surface0: palette.surface0
    readonly property color base: palette.base
    readonly property color mantle: palette.mantle
    readonly property color crust: palette.crust

    readonly property color accent: palette.mauve
}
