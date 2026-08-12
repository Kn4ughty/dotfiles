pragma ComponentBehavior: Bound

import QtQuick

import ".." as Root

// Right side of the bar
Item {
    id: root

    required property var modelData

    implicitWidth: row.implicitWidth + Root.Config.bar_item_padding
    implicitHeight: row.implicitHeight

    anchors.leftMargin: Root.Config.bar_item_padding

    Row {
        id: row
        spacing: Root.Config.bar_item_padding

        Repeater {
            model: Workspaces.workspaces.filter(w => w.output === root.modelData.name)

            Rectangle {
                id: workspace

                required property var modelData

                width: 20
                height: 20
                radius: 10

                color: {
                    if (workspace.modelData.focused) {
                        return Root.Colours.surface0T;
                    } else {
                        return "transparent";
                    }
                }

                border {
                    color: workspace.modelData.focused ? Root.Colours.surface2 : "transparent"
                }

                TextTemplate {
                    anchors.centerIn: parent
                    anchors {
                        leftMargin: 5
                        rightMargin: 5
                    }
                    content: workspace.modelData.num
                }
            }
        }
    }
}
