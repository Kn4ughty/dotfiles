import QtQuick

import ".." as Root

Text {
    required property string content

    font {
        family: Root.Config.font_family
        pointSize: Root.Config.point_size
        bold: true
    }

    text: content
    color: Root.Colours.text
}
