import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

Item {
    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

    function volIcon(vol, muted) {
        if (muted || vol === 0) return "󰝟"
        if (vol < 34)           return "󰕿"
        if (vol < 67)           return "󰖀"
        return "󰕾"
    }

    Pill {
        id: pill
        anchors.fill: parent
        hPad: 12
        vPad: 7

        RowLayout {
            spacing: 10

            RowLayout {
                spacing: 5
                Text {
                    text: volIcon(
                        Math.round((Pipewire.defaultAudioSink?.audio?.volume ?? 0) * 100),
                        Pipewire.defaultAudioSink?.audio?.muted ?? false)
                    color: Colors.secondary
                    font.pixelSize: 16
                    font.family: "JetBrainsMono Nerd Font"
                }
                Text {
                    text: Math.round((Pipewire.defaultAudioSink?.audio?.volume ?? 0) * 100) + "%"
                    color: Colors.pillText
                    font.pixelSize: 15
                    font.family: "JetBrainsMono Nerd Font"
                    font.weight: Font.Medium
                }
            }

            Rectangle {
                width: 1; height: 14
                color: Colors.pillBorder
                opacity: 0.6
            }

            RowLayout {
                spacing: 5
                Text {
                    text: Pipewire.defaultAudioSource?.audio?.muted ? "󰍭" : "󰍬"
                    color: Pipewire.defaultAudioSource?.audio?.muted ? Colors.errorColor : Colors.secondary
                    font.pixelSize: 15
                    font.family: "JetBrainsMono Nerd Font"
                }
                Text {
                    text: Math.round((Pipewire.defaultAudioSource?.audio?.volume ?? 0) * 100) + "%"
                    color: Colors.pillText
                    font.pixelSize: 15
                    font.family: "JetBrainsMono Nerd Font"
                    font.weight: Font.Medium
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onWheel: (wheel) => {
            const sink = Pipewire.defaultAudioSink
            if (!sink) return
            const delta = wheel.angleDelta.y > 0 ? 0.02 : -0.02
            sink.audio.volume = Math.max(0, Math.min(1.5, sink.audio.volume + delta))
        }
        onClicked: {
            const sink = Pipewire.defaultAudioSink
            if (sink) sink.audio.muted = !sink.audio.muted
        }
    }
}
