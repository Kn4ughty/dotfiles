pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

// Right side of the bar
Item {
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    Row {
        id: row
        spacing: 10
    }
}
