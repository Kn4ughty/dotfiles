pragma ComponentBehavior: Bound

import Quickshell // for PanelWindow
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
                id: panel
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

                    anchors {
                        fill: parent

                        leftMargin: config.margin
                        rightMargin: config.margin
                        topMargin: config.margin
                    }

                    color: Root.Colours.baseT
                    radius: height / 2

                    border {
                        width: 1.2
                        color: Root.Colours.surface2
                    }

                    BarLeft {
                        anchors {
                            left: parent.left
                            verticalCenter: parent.verticalCenter
                        }
                        modelData: panel.modelData
                    }

                    BarMiddle {}

                    BarRight {
                        anchors {
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
}
