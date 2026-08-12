pragma ComponentBehavior: Bound

import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text

import ".." as Root

Scope {

    QtObject {
        id: config

        property int margin: 5
    }

    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData

                implicitHeight: 40

                color: "transparent"

                anchors {
                    top: true
                    left: true
                    right: true
                }

                Rectangle {
                    anchors.fill: parent

                    color: "transparent"

                    Rectangle {

                        color: Root.Colours.base
                        radius: height / 2

                        anchors {
                            fill: parent

                            leftMargin: config.margin
                            rightMargin: config.margin
                            topMargin: config.margin
                        }

                        // Rectangle {
                        //     anchors.horizontalCenter: parent.horizontalCenter

                        Text {
                            text: "TEST"
                            color: "magenta"
                        }
                        BarRight {}
                        // }
                    }
                }
            }
        }
    }
}
