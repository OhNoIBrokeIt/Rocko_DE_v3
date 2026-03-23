import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Pill {
    hPad: 12
    vPad: 10

    RowLayout {
        spacing: 7

        Repeater {
            model: 9

            delegate: Rectangle {
                required property int index
                readonly property int wsId: index + 1
                readonly property bool isActive: wsId === Hyprland.focusedMonitor?.activeWorkspace?.id
                readonly property bool exists: Hyprland.workspaces.values.some(w => w.id === wsId)
                readonly property bool hasWindows: {
                    const ws = Hyprland.workspaces.values.find(w => w.id === wsId)
                    return ws ? ws.clientCount > 0 : false
                }

                width:  isActive ? 24 : 8
                height: 8
                radius: 4

                opacity: exists ? 1.0 : 0.2

                color: isActive   ? Colors.primary
                     : hasWindows ? Colors.pillMuted
                     :              Colors.pillBorder

                Behavior on width   { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
                Behavior on opacity { NumberAnimation { duration: 150 } }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + wsId)
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
