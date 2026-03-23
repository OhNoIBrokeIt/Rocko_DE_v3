import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

Item {
    implicitWidth: pill.implicitWidth
    implicitHeight: pill.implicitHeight

    readonly property MprisPlayer activePlayer: {
        const players = Mpris.players
        for (let i = 0; i < players.values.length; i++) {
            const p = players.values[i]
            if (p.playbackState === MprisPlaybackState.Playing) return p
        }
        return players.values.length > 0 ? players.values[0] : null
    }

    visible: !!activePlayer

    Pill {
        id: pill
        anchors.fill: parent
        hPad: 10
        vPad: 6

        RowLayout {
            spacing: 8

            Rectangle {
                width: 28; height: 28
                radius: 6
                color: Colors.surfaceVariant
                clip: true

                Image {
                    anchors.fill: parent
                    source: activePlayer?.trackArtUrl ?? ""
                    fillMode: Image.PreserveAspectCrop
                    visible: status === Image.Ready
                }

                Text {
                    anchors.centerIn: parent
                    text: "󰎆"
                    color: Colors.pillMuted
                    font.pixelSize: 14
                    font.family: "JetBrainsMono Nerd Font"
                    visible: parent.children[0].status !== Image.Ready
                }
            }

            ColumnLayout {
                spacing: 1
                Layout.maximumWidth: 220

                Text {
                    Layout.fillWidth: true
                    text: activePlayer?.trackTitle ?? ""
                    color: Colors.pillText
                    font.pixelSize: 15
                    font.weight: Font.Medium
                    font.family: "JetBrainsMono Nerd Font"
                    elide: Text.ElideRight
                }

                Text {
                    Layout.fillWidth: true
                    text: activePlayer?.trackArtist ?? ""
                    color: Colors.pillMuted
                    font.pixelSize: 11
                    font.family: "JetBrainsMono Nerd Font"
                    elide: Text.ElideRight
                }
            }

            RowLayout {
                spacing: 2

                Text {
                    text: "󰒮"
                    color: Colors.secondary
                    font.pixelSize: 18
                    font.family: "JetBrainsMono Nerd Font"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: activePlayer?.previous()
                    }
                }

                Text {
                    text: activePlayer?.playbackState === MprisPlaybackState.Playing ? "󰏤" : "󰐊"
                    color: Colors.secondary
                    font.pixelSize: 18
                    font.family: "JetBrainsMono Nerd Font"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: activePlayer?.togglePlaying()
                    }
                }

                Text {
                    text: "󰒭"
                    color: Colors.secondary
                    font.pixelSize: 18
                    font.family: "JetBrainsMono Nerd Font"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: activePlayer?.next()
                    }
                }
            }
        }
    }
}
