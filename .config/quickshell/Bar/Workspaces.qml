pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property var workspaces: []

    function refresh() {
        get_workspaces.running = true;
    }

    function set_workspace(space) {
        proc_set_workspace.new_workspace = space;
        proc_set_workspace.running = true;
    }

    Process {
        id: proc_set_workspace
        property var new_workspace: 1

        command: ["swaymsg", "workspace", new_workspace]
        running: false
    }

    Process {
        id: get_workspaces
        command: ["swaymsg", "-t", "get_workspaces", "--raw"]
        stdout: StdioCollector {
            onStreamFinished: root.workspaces = JSON.parse(this.text)
        }
    }

    Process {
        id: monitor_workspace_change
        // needs --raw so that it can be newline delimited to detect changes
        command: ["swaymsg", "-t", "subscribe", "-m", "[\"workspace\"]", "--raw"]

        running: true
        stdout: SplitParser {
            onRead: root.refresh()
        }
    }

    Component.onCompleted: refresh()
}
