pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

// Right side of the bar
Scope {

    Rectangle {
        Text {
            text: "RIGHT TEXT"
            color: "red"
        }

        ClockWidget {
            // anchors.centerIn: parent
        }
    }
}
