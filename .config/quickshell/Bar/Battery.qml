pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // made up data to avoid undefined warnings
    property var battery_info: {
        "percent": "󰁾 XX%",
        "time": "0.0 hours ",
        "icon": "󱉝"
    }

    Process {
        id: battery_mon

        command: ["/home/d/.config/quickshell/scripts/battery.sh"]
        stdout: SplitParser {
            onRead: data => {
                if (data) {
                    root.battery_info = JSON.parse(data);
                }
            }
        }

        running: true
    }
}
