import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

import "Components" as Components

Scope {
    id: root

    property real volume: 0
    

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio
    }

    Components.Slider {
        driver: Pipewire.defaultAudioSink?.audio.volume ?? 0
        iconName:  "audio-volume-high-symbolic"
    }
}
