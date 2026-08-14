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

        TextTemplate {
            id: battery
            content: Battery.battery_info.percent
        }

        // todo. make seperator template
        TextTemplate {
            content: "\\\\"
        }

        TextTemplate {
            id: tt
            content: Time.time
        }
    }
}
