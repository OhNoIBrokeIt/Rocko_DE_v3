import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Pill {
    hPad: 12
    vPad: 7

    RowLayout {
        spacing: 10

        // ── CPU ───────────────────────────────────────────────
        RowLayout {
            spacing: 4

            Text {
                text: " "
                color: Colors.secondary
                font.pixelSize: 13
                font.family: "JetBrainsMono Nerd Font"
            }

            Text {
                id: cpuTxt
                text: "?%"
                color: Colors.pillText
                font.pixelSize: 13
                font.family: "JetBrainsMono Nerd Font"
                font.weight: Font.Medium
            }

            Text {
                id: cpuTempTxt
                text: ""
                color: Colors.pillMuted
                font.pixelSize: 11
                font.family: "JetBrainsMono Nerd Font"
            }
        }

        // Divider
        Rectangle {
            width: 1; height: 14
            color: Colors.pillBorder
            opacity: 0.6
        }

        // ── GPU ───────────────────────────────────────────────
        RowLayout {
            spacing: 4

            Text {
                text: "󰍛 "
                color: Colors.secondary
                font.pixelSize: 13
                font.family: "JetBrainsMono Nerd Font"
            }

            Text {
                id: gpuTxt
                text: "?%"
                color: Colors.pillText
                font.pixelSize: 13
                font.family: "JetBrainsMono Nerd Font"
                font.weight: Font.Medium
            }

            Text {
                id: gpuTempTxt
                text: ""
                color: Colors.pillMuted
                font.pixelSize: 11
                font.family: "JetBrainsMono Nerd Font"
            }
        }
    }

    // ── CPU poller ────────────────────────────────────────────
    Process {
        id: cpuProc
        command: ["bash", "-c",
            "awk '/^cpu /{u=$2+$4;t=$2+$3+$4+$5; if(t>0) printf \"%.0f\",u/t*100}' /proc/stat; " +
            "sensors 2>/dev/null | awk '/Package id 0/{printf \" %.0f°\", $4}' | head -1"]
        running: true

        stdout: SplitParser {
            onRead: (line) => {
                const parts = line.trim().split(" ")
                cpuTxt.text     = (parts[0] || "?") + "%"
                cpuTempTxt.text = parts[1] || ""
            }
        }
    }

    Timer {
        interval: 3000
        repeat: true
        running: true
        onTriggered: cpuProc.running = true
    }

    // ── GPU poller ────────────────────────────────────────────
    Process {
        id: gpuProc
        command: ["bash", "-c",
            "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits 2>/dev/null | " +
            "awk -F, '{printf \"%d%% %d°\",$1,$2}'"]
        running: true

        stdout: SplitParser {
            onRead: (line) => {
                const parts = line.trim().split(" ")
                gpuTxt.text     = parts[0] || "?%"
                gpuTempTxt.text = parts[1] ? parts[1] + "" : ""
            }
        }
    }

    Timer {
        interval: 3000
        repeat: true
        running: true
        onTriggered: gpuProc.running = true
    }
}
