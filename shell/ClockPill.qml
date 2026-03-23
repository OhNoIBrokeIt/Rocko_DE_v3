import QtQuick
import QtQuick.Layouts
import Quickshell

Pill {
    hPad: 14

    ColumnLayout {
        spacing: 0

        Text {
            id: timeTxt
            Layout.alignment: Qt.AlignHCenter
            text: Qt.formatTime(new Date(), "hh:mm")
            color: Colors.pillText
            font.pixelSize: 15
            font.weight: Font.Bold
            font.family: "JetBrainsMono Nerd Font"
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: Qt.formatDate(new Date(), "ddd, MMM d")
            color: Colors.pillMuted
            font.pixelSize: 11
            font.family: "JetBrainsMono Nerd Font"
        }
    }

    SystemClock {
        precision: SystemClock.Minutes
        onTimeChanged: timeTxt.text = Qt.formatTime(new Date(), "hh:mm")
    }
}
