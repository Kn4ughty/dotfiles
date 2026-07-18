pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import ".."

Scope {
    id: root

    required property real driver
    required property string iconName

    QtObject {
        id: internal
        property bool shouldShowOsd: false
        property bool osdLoaded: false
        property bool readyToShow: false
    }

    onDriverChanged: {
        if (!internal.readyToShow)
            return;
        internal.shouldShowOsd = true;
        unloadTimer.stop();

        internal.osdLoaded = true;
        hideTimer.restart();
    }

    Component.onCompleted: {
        Qt.callLater(() => internal.readyToShow = true);
    }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: {
            internal.shouldShowOsd = false;
            unloadTimer.restart();
        }
    }

    Timer {
        id: unloadTimer
        interval: 300
        onTriggered: internal.osdLoaded = false
    }

    LazyLoader {
        active: internal.osdLoaded

        PanelWindow {
            anchors.top: true
            margins.top: 15
            exclusiveZone: 0

            implicitWidth: 400
            implicitHeight: 45
            color: "transparent"

            // Empty mask to prevent blocking mouse events
            mask: Region {}

            Rectangle {
                id: osd

                property bool revealed: false

                width: parent.width - 4
                height: parent.height - 4
                radius: height / 2
                color: Colours.crust

                border {
                    color: Colours.surface0
                    width: 1
                }

                anchors {
                    horizontalCenter: parent.horizontalCenter
                }

                opacity: (internal.shouldShowOsd && revealed) ? 1 : 0

                y: (internal.shouldShowOsd && revealed) ? 0 : -height

                Behavior on opacity {
                    NumberAnimation {
                        duration: 150
                    }
                }

                Behavior on y {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutBack
                    }
                }

                Component.onCompleted: revealed = true

                Rectangle {
                    id: fill
                    color: Colours.accent
                    radius: parent.radius

                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                        margins: 6
                    }

                    width: parent.width * root.driver
                    Behavior on width {
                        SpringAnimation {
                            spring: 5
                            damping: 0.3
                        }
                    }

                    property real _lastWidth: width

                    transform: Scale {
                        id: squash
                        origin.x: 0
                        origin.y: fill.height / 2
                        yScale: 1

                        Behavior on yScale {
                            SpringAnimation {
                                spring: 2
                                damping: 0.9
                            }
                        }
                    }

                    onWidthChanged: {
                        squash.yScale = width < _lastWidth ? 1.1 : 0.9;
                        _lastWidth = width;
                        // squash.yScale = 1
                        squashReset.restart();
                    }

                    Timer {
                        id: squashReset
                        interval: 16
                        onTriggered: squash.yScale = 1
                    }
                }

                ColorableIcon {

                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                        leftMargin: 12
                    }

                    iconSize: 18
                    iconName: root.iconName
                    iconColor: Colours.crust
                }

                Text {
                    color: Colours.accent
                    font {
                        family: "Lexend Deca"
                        // family: "Aller"
                        pointSize: 20
                        preferShaping: false
                    }
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                        rightMargin: 12
                    }
                    text: Math.round((root.driver) * 100)
                }
            }
        }
    }
}
