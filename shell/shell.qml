import Quickshell
import Quickshell.Hyprland
import QtQuick

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            visible: true
            implicitHeight: 56

            anchors.top: true
            anchors.left: true
            anchors.right: true

            TopBar {
                anchors.fill: parent
            }
        }
    }
}
