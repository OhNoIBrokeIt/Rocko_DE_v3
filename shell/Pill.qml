import QtQuick
import QtQuick.Layouts

Item {
    id: root

    // ── Public API ────────────────────────────────────────────
    default property alias content: innerLayout.children
    property real  hPad:   12
    property real  vPad:   6
    property color bgColor:     Colors.pillBg
    property color borderColor: Colors.pillBorder
    property real  borderWidth: 1
    property real  radius:      16

    // ── Size ──────────────────────────────────────────────────
    implicitWidth:  bg.implicitWidth
    implicitHeight: bg.implicitHeight

    Rectangle {
        id: bg
        anchors.fill: parent
        radius: root.radius
        color:  root.bgColor

        border.color: root.borderColor
        border.width: root.borderWidth

        implicitWidth:  innerLayout.implicitWidth  + root.hPad * 2
        implicitHeight: innerLayout.implicitHeight + root.vPad * 2

        RowLayout {
            id: innerLayout
            anchors.centerIn: parent
            spacing: 6
        }
    }

    Behavior on bgColor     { ColorAnimation { duration: 300 } }
    Behavior on borderColor { ColorAnimation { duration: 300 } }
}
