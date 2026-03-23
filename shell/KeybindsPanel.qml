import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

PersistentWindow {
    id: root

    visible: false
    layer: "overlay"
    screen: Quickshell.screens[0]

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    HyprlandIpcClient {
        onEvent: (type, data) => {
            if (type === "custom" && data === "rocko-keybinds-toggle")
                root.visible = !root.visible
        }
    }

    // Dimmed overlay
    Rectangle {
        anchors.fill: parent
        color: "#80000000"

        MouseArea {
            anchors.fill: parent
            onClicked: root.visible = false
        }

        // Cheatsheet card
        Rectangle {
            anchors.centerIn: parent
            width: 680
            height: Math.min(grid.implicitHeight + 80, parent.height - 80)
            radius: 20
            color: Colors.surface
            border.color: Colors.pillBorder
            border.width: 1

            ColumnLayout {
                anchors {
                    fill: parent
                    margins: 24
                }
                spacing: 16

                Text {
                    text: "Keybinds"
                    color: Colors.onSurface
                    font.pixelSize: 16
                    font.weight: Font.Bold
                    font.family: "JetBrainsMono Nerd Font"
                }

                GridLayout {
                    id: grid
                    Layout.fillWidth: true
                    columns: 2
                    columnSpacing: 32
                    rowSpacing: 8

                    Repeater {
                        model: [
                            { key: "Super + T",          action: "Terminal" },
                            { key: "Super + B",          action: "Browser" },
                            { key: "Super + E",          action: "File manager" },
                            { key: "Super + D",          action: "App launcher" },
                            { key: "Super + Q",          action: "Close window" },
                            { key: "Super + F",          action: "Fullscreen" },
                            { key: "Super + Space",      action: "Float toggle" },
                            { key: "Super + X",          action: "Power menu" },
                            { key: "Super + A",          action: "Audio panel" },
                            { key: "Super + /",          action: "This cheatsheet" },
                            { key: "Super + Shift + W",  action: "Random wallpaper" },
                            { key: "Super + Shift + R",  action: "Reload shell" },
                            { key: "Super + 1-9",        action: "Switch workspace" },
                            { key: "Super + Shift + 1-9",action: "Move to workspace" },
                            { key: "Super + ` ",         action: "Scratchpad terminal" },
                            { key: "Super + F1",         action: "Scratchpad files" },
                            { key: "Super + I",          action: "Idle inhibitor" },
                            { key: "Super + L",          action: "Lock screen" },
                        ]

                        delegate: RowLayout {
                            required property var modelData
                            Layout.fillWidth: true
                            spacing: 12

                            Rectangle {
                                implicitWidth: keyTxt.implicitWidth + 12
                                height: 22
                                radius: 5
                                color: Colors.surfaceVariant

                                Text {
                                    id: keyTxt
                                    anchors.centerIn: parent
                                    text: modelData.key
                                    color: Colors.primary
                                    font.pixelSize: 11
                                    font.family: "JetBrainsMono Nerd Font"
                                    font.weight: Font.Medium
                                }
                            }

                            Text {
                                Layout.fillWidth: true
                                text: modelData.action
                                color: Colors.pillMuted
                                font.pixelSize: 13
                                font.family: "JetBrainsMono Nerd Font"
                                elide: Text.ElideRight
                            }
                        }
                    }
                }
            }
        }
    }
}
