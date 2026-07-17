import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            implicitHeight: 30

            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            Rectangle  {
                anchors.fill: parent

                color: "white"
                radius: height / 2


                ClockWidget {
                    anchors.centerIn: parent
                }
            }
        }
    }
}
