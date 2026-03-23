pragma Singleton
import QtQuick

Item {
    id: root

    readonly property color primary:        "#cba6f7"
    readonly property color primaryOn:      "#1e1e2e"
    readonly property color secondary:      "#89b4fa"
    readonly property color surface:        "#1e1e2e"
    readonly property color surfaceVariant: "#313244"
    readonly property color surfaceText:    "#cdd6f4"
    readonly property color outline:        "#585b70"
    readonly property color errorColor:     "#f38ba8"

    readonly property color pillBg:     "#22222e"
    readonly property color pillBorder: "#585b70"
    readonly property color pillText:   "#cdd6f4"
    readonly property color pillAccent: "#cba6f7"
    readonly property color pillMuted:  "#6c7086"
}
