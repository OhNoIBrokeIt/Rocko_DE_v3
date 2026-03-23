import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Item {
    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

    property string cpuText:     "?%"
    property string cpuTempText: ""
    property string gpuText:     "?%"
    property string gpuTempText: ""

    Pill {
        id: pill
        anchors.fill: parent
        hPad: 12
        vPad: 7

        RowLayout {
            spacing: 10

            RowLayout {
                spacing: 4
                Text {
                    text: " "
                    color: Colors.secondary
                    font.pixelSize: 15
                    font.family: "JetBrainsMono Nerd Font"
                }
                Text {
                    text: cpuText
                    color: Colors.pillText
                    font.pixelSize: 15
                    font.family: "JetBrainsMono Nerd Font"
                    font.weight: Font.Medium
                }
                Text {
                    text: cpuTempText
                    color: Colors.pillMuted
                    font.pixelSize: 11
                    font.family: "JetBrainsMono Nerd Font"
                }
            }

            Rectangle {
                width: 1; height: 14
                color: Colors.pillBorder
                opacity: 0.6
            }

            RowLayout {
                spacing: 4
                Text {
                    text: "󰍛 "
                    color: Colors.secondary
                    font.pixelSize: 15
                    font.family: "JetBrainsMono Nerd Font"
                }
                Text {
                    text: gpuText
                    color: Colors.pillText
                    font.pixelSize: 15
                    font.family: "JetBrainsMono Nerd Font"
                    font.weight: Font.Medium
                }
                Text {
                    text: gpuTempText
                    color: Colors.pillMuted
                    font.pixelSize: 11
                    font.family: "JetBrainsMono Nerd Font"
                }
            }
        }
    }

    Process {
        id: cpuProc
        command: ["bash", "-c",
            "awk '/^cpu /{u=$2+$4;t=$2+$3+$4+$5; if(t>0) printf \"%.0f\",u/t*100}' /proc/stat"]
        running: true
        stdout: SplitParser {
            onRead: (line) => { cpuText = line.trim() + "%" }
        }
    }

    Process {
        id: gpuProc
        command: ["bash", "-c",
            "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits 2>/dev/null | awk -F, '{printf \"%d%% %d°\",$1,$2}'"]
        running: true
        stdout: SplitParser {
            onRead: (line) => {
                const parts = line.trim().split(" ")
                gpuText     = parts[0] || "?%"
                gpuTempText = parts[1] || ""
            }
        }
    }

    Timer {
        interval: 3000
        repeat: true
        running: true
        onTriggered: {
            cpuProc.running = true
            gpuProc.running = true
        }
    }
}
