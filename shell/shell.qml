import Quickshell
import Quickshell.Hyprland
import QtQuick

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens

        PersistentWindow {
            required property var modelData
            readonly property var screen: modelData

            screen: modelData
            visible: true

            anchors {
                top: true
                left: true
                right: true
            }

            height: 48
            exclusiveZone: 48
            layer: "top"

            TopBar {
                anchors.fill: parent
                screen: parent.screen
            }
        }
    }

    AudioPanel {}
    PowerPanel {}
    KeybindsPanel {}
}
