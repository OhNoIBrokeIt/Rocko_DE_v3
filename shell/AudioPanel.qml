import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Hyprland

PersistentWindow {
    id: root

    visible: false
    layer: "overlay"
    screen: Quickshell.screens[0]

    anchors {
        top: true
        right: true
    }

    width: 300
    height: contentCol.implicitHeight + 32

    // ── Toggle via Hyprland IPC ───────────────────────────────
    HyprlandIpcClient {
        onEvent: (type, data) => {
            if (type === "activewindow") return
            if (type === "custom" && data === "rocko-audio-toggle")
                root.visible = !root.visible
        }
    }

    // ── Panel surface ─────────────────────────────────────────
    Rectangle {
        anchors.fill: parent
        anchors.margins: 8
        radius: 16
        color: Colors.surface
        border.color: Colors.pillBorder
        border.width: 1

        ColumnLayout {
            id: contentCol
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 16
            }
            spacing: 12

            Text {
                text: "Audio"
                color: Colors.onSurface
                font.pixelSize: 14
                font.weight: Font.Bold
                font.family: "JetBrainsMono Nerd Font"
            }

            // Output volume slider
            RowLayout {
                spacing: 8
                Layout.fillWidth: true

                Text {
                    text: "󰕾"
                    color: Colors.secondary
                    font.pixelSize: 16
                    font.family: "JetBrainsMono Nerd Font"
                }

                Slider {
                    id: volSlider
                    Layout.fillWidth: true
                    from: 0; to: 1.5
                    value: PwNodeTracker.defaultSink?.audio?.volume ?? 0
                    onMoved: {
                        if (PwNodeTracker.defaultSink)
                            PwNodeTracker.defaultSink.audio.volume = value
                    }
                    stepSize: 0.01
                }

                Text {
                    text: Math.round(volSlider.value * 100) + "%"
                    color: Colors.pillMuted
                    font.pixelSize: 12
                    font.family: "JetBrainsMono Nerd Font"
                    width: 36
                }
            }

            // Mic volume slider
            RowLayout {
                spacing: 8
                Layout.fillWidth: true

                Text {
                    text: "󰍬"
                    color: Colors.secondary
                    font.pixelSize: 16
                    font.family: "JetBrainsMono Nerd Font"
                }

                Slider {
                    id: micSlider
                    Layout.fillWidth: true
                    from: 0; to: 1.0
                    value: PwNodeTracker.defaultSource?.audio?.volume ?? 0
                    onMoved: {
                        if (PwNodeTracker.defaultSource)
                            PwNodeTracker.defaultSource.audio.volume = value
                    }
                    stepSize: 0.01
                }

                Text {
                    text: Math.round(micSlider.value * 100) + "%"
                    color: Colors.pillMuted
                    font.pixelSize: 12
                    font.family: "JetBrainsMono Nerd Font"
                    width: 36
                }
            }
        }
    }

    // Dismiss on outside click
    MouseArea {
        anchors.fill: parent
        onClicked: root.visible = false
        z: -1
    }
}
