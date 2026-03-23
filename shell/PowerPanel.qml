import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

PersistentWindow {
    id: root

    visible: false
    layer: "overlay"
    screen: Quickshell.screens[0]

    anchors {
        top: true
        right: true
    }

    width: 200

    HyprlandIpcClient {
        onEvent: (type, data) => {
            if (type === "custom" && data === "rocko-power-toggle")
                root.visible = !root.visible
        }
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 8
        radius: 16
        color: Colors.surface
        border.color: Colors.pillBorder
        border.width: 1
        implicitHeight: btnCol.implicitHeight + 32

        ColumnLayout {
            id: btnCol
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 12
            }
            spacing: 4

            Repeater {
                model: [
                    { label: "Lock",        icon: "󰌾", cmd: "hyprctl dispatch exec hyprlock" },
                    { label: "Suspend",      icon: "󰤄", cmd: "systemctl suspend" },
                    { label: "Reboot",       icon: "󰜉", cmd: "systemctl reboot" },
                    { label: "Shut down",    icon: "󰐥", cmd: "systemctl poweroff" },
                    { label: "Log out",      icon: "󰍃", cmd: "hyprctl dispatch exit" }
                ]

                delegate: Rectangle {
                    required property var modelData
                    Layout.fillWidth: true
                    height: 44
                    radius: 10
                    color: hovered ? Colors.surfaceVariant : "transparent"
                    property bool hovered: false

                    RowLayout {
                        anchors {
                            fill: parent
                            leftMargin: 12
                            rightMargin: 12
                        }
                        spacing: 10

                        Text {
                            text: modelData.icon
                            color: Colors.secondary
                            font.pixelSize: 16
                            font.family: "JetBrainsMono Nerd Font"
                        }

                        Text {
                            text: modelData.label
                            color: Colors.onSurface
                            font.pixelSize: 13
                            font.family: "JetBrainsMono Nerd Font"
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onEntered: parent.hovered = true
                        onExited:  parent.hovered = false
                        onClicked: {
                            root.visible = false
                            Process { command: ["bash", "-c", modelData.cmd]; running: true }
                        }
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.visible = false
        z: -1
    }
}
