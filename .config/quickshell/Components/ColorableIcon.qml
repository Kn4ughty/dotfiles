import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets

Item {
    id: root

    property string iconName: ""
    // property color iconColor: "#cad3f5"
    property color iconColor: "#a5adcb"
    property alias iconSize: icon.implicitSize

    implicitWidth: icon.implicitSize
    implicitHeight: icon.implicitSize

    IconImage {
        id: icon
        anchors.fill: parent
        source: Quickshell.iconPath(root.iconName)
        visible: false
    }

    MultiEffect {
        anchors.fill: icon
        source: icon
        colorization: 1.0
        colorizationColor: root.iconColor
        brightness: 1.0
    }
}
