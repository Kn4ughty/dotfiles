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

                    color: Root.Colours.mantleT
                    radius: height / 2

                    anchors {
                        fill: parent

                        leftMargin: config.margin
                        rightMargin: config.margin
                        topMargin: config.margin
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
