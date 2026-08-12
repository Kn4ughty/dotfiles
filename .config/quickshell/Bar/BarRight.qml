pragma ComponentBehavior: Bound

import QtQuick

import ".." as Root

// Right side of the bar
Item {
    implicitWidth: row.implicitWidth + Root.Config.bar_item_padding

    implicitHeight: row.implicitHeight

    Row {
        id: row

        spacing: Root.Config.bar_item_padding

        Item {
            implicitWidth: tt.implicitWidth
            implicitHeight: tt.implicitHeight

            TextTemplate {
                id: tt
                content: Time.time
            }
        }
    }
}
