pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string font_family: "JetBrainsMono NF"
    readonly property int point_size: 12

    readonly property int bar_item_padding: 10
}
