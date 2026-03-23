import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

Pill {
    id: root
    hPad: 12
    vPad: 7

    // ── Volume icon helper ────────────────────────────────────
    function volIcon(vol, muted) {
        if (muted || vol === 0) return "󰝟"
        if (vol < 34)           return "󰕿"
        if (vol < 67)           return "󰖀"
        return "󰕾"
    }

    RowLayout {
        spacing: 10

        // ── Output volume ─────────────────────────────────────
        RowLayout {
            spacing: 5

            Text {
                text: root.volIcon(
                    Math.round((PwNodeTracker.defaultSink?.audio?.volume ?? 0) * 100),
                    PwNodeTracker.defaultSink?.audio?.muted ?? false)
                color: Colors.secondary
                font.pixelSize: 14
                font.family: "JetBrainsMono Nerd Font"
            }

            Text {
                text: Math.round((PwNodeTracker.defaultSink?.audio?.volume ?? 0) * 100) + "%"
                color: Colors.pillText
                font.pixelSize: 13
                font.family: "JetBrainsMono Nerd Font"
                font.weight: Font.Medium
            }

            // Sample rate badge
            Text {
                text: {
                    const rate = PwNodeTracker.defaultSink?.audio?.rate ?? 0
                    if (!rate) return ""
                    return rate >= 1000 ? (rate / 1000).toFixed(1) + "k" : rate + "Hz"
                }
                color: Colors.pillMuted
                font.pixelSize: 10
                font.family: "JetBrainsMono Nerd Font"
                visible: text.length > 0
            }
        }

        // Divider
        Rectangle {
            width: 1; height: 14
            color: Colors.pillBorder
            opacity: 0.6
        }

        // ── Mic ───────────────────────────────────────────────
        RowLayout {
            spacing: 5

            Text {
                text: PwNodeTracker.defaultSource?.audio?.muted ? "󰍭" : "󰍬"
                color: PwNodeTracker.defaultSource?.audio?.muted ? Colors.error : Colors.secondary
                font.pixelSize: 13
                font.family: "JetBrainsMono Nerd Font"
            }

            Text {
                text: Math.round((PwNodeTracker.defaultSource?.audio?.volume ?? 0) * 100) + "%"
                color: Colors.pillText
                font.pixelSize: 13
                font.family: "JetBrainsMono Nerd Font"
                font.weight: Font.Medium
            }
        }
    }

    // ── Scroll to adjust volume ───────────────────────────────
    MouseArea {
        anchors.fill: parent
        onWheel: (wheel) => {
            const sink = PwNodeTracker.defaultSink
            if (!sink) return
            const delta = wheel.angleDelta.y > 0 ? 0.02 : -0.02
            sink.audio.volume = Math.max(0, Math.min(1.5, sink.audio.volume + delta))
        }
        onClicked: {
            if (PwNodeTracker.defaultSink)
                PwNodeTracker.defaultSink.audio.muted = !PwNodeTracker.defaultSink.audio.muted
        }
    }
}
