import QtQuick
import QtQuick.Layouts

Item {
    id: root
    required property var screen

    // ── Background ────────────────────────────────────────────
    Rectangle {
        anchors.fill: parent
        color: "transparent"
    }

    // ── Three-region layout ───────────────────────────────────
    RowLayout {
        anchors {
            fill: parent
            leftMargin:  8
            rightMargin: 8
            topMargin:   4
            bottomMargin: 4
        }
        spacing: 0

        // LEFT — workspaces + window title
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            WorkspacesPill {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                screen: root.screen
            }
        }

        // CENTER — music + clock
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

        // RIGHT — stats + audio
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
