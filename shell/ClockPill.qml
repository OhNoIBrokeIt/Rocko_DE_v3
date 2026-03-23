import QtQuick
import QtQuick.Layouts

Item {
    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

    Pill {
        id: pill
        anchors.fill: parent
        hPad: 16

        Text {
            id: timeTxt
            text: Qt.formatTime(new Date(), "hh:mm") + "  " + Qt.formatDate(new Date(), "ddd, MMM d")
            color: Colors.pillText
            font.pixelSize: 16
            font.weight: Font.Medium
            font.family: "JetBrainsMono Nerd Font"
        }
    }

    Timer {
        interval: 10000
        repeat: true
        running: true
        onTriggered: {
            timeTxt.text = Qt.formatTime(new Date(), "hh:mm") + "  " + Qt.formatDate(new Date(), "ddd, MMM d")
        }
    }
}
