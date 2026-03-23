import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Pill {
    id: root

    required property var screen

    hPad: 8
    vPad: 6

    RowLayout {
        spacing: 4

        Repeater {
            model: Hyprland.workspaces

            delegate: Rectangle {
                required property var modelData

                readonly property bool isActive:  modelData.id === Hyprland.focusedMonitor?.activeWorkspace?.id
                readonly property bool hasWindows: modelData.windowCount > 0

                width:  isActive ? 28 : 10
                height: 10
                radius: 5

                color: isActive
                    ? Colors.primary
                    : hasWindows
                        ? Colors.pillMuted
                        : Qt.rgba(Colors.onSurface.r, Colors.onSurface.g, Colors.onSurface.b, 0.15)

                Behavior on width  { NumberAnimation  { duration: 200; easing.type: Easing.OutCubic } }
                Behavior on color  { ColorAnimation   { duration: 200 } }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + modelData.id)
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }

    // Window title — only show on focused monitor
    Text {
        visible: root.screen?.name === Hyprland.focusedMonitor?.name
        text: {
            const win = Hyprland.focusedClient
            if (!win || !win.title) return ""
            const t = win.title
            return t.length > 40 ? t.slice(0, 38) + "…" : t
        }
        color:    Colors.pillText
        font.pixelSize: 13
        font.family: "JetBrainsMono Nerd Font"
        leftPadding: 8
        opacity: 0.85
    }
}
