import QtQuick
import QtQuick.Layouts

Item {
    id: root

    Rectangle {
        anchors.fill: parent
        color: "transparent"
    }

    RowLayout {
        anchors {
            fill: parent
            leftMargin:  8
            rightMargin: 8
            topMargin:   4
            bottomMargin: 4
        }
        spacing: 0

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            WorkspacesPill {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {
                anchors.centerIn: parent
                spacing: 6

                MusicPill {}
                ClockPill {}
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                spacing: 6

                SystemStatsPill {}
                AudioPill {}
            }
        }
    }
}
