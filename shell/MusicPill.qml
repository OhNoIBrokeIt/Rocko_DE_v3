import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

Pill {
    id: root

    visible: !!activePlayer
    hPad: 10
    vPad: 6

    readonly property MprisPlayer activePlayer: {
        const players = MprisController.players
        for (let i = 0; i < players.values.length; i++) {
            const p = players.values[i]
            if (p.playbackState === MprisPlaybackState.Playing) return p
        }
        return players.values.length > 0 ? players.values[0] : null
    }

    RowLayout {
        spacing: 8

        // ── Album art ─────────────────────────────────────────
        Rectangle {
            width: 28; height: 28
            radius: 6
            color: Colors.surfaceVariant
            clip: true

            Image {
                anchors.fill: parent
                source: root.activePlayer?.metadata?.artUrl ?? ""
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

        // ── Track info ────────────────────────────────────────
        ColumnLayout {
            spacing: 1
            Layout.maximumWidth: 220

            Text {
                id: titleTxt
                Layout.fillWidth: true
                text: root.activePlayer?.metadata?.title ?? ""
                color: Colors.pillText
                font.pixelSize: 13
                font.weight: Font.Medium
                font.family: "JetBrainsMono Nerd Font"
                elide: Text.ElideRight
            }

            Text {
                Layout.fillWidth: true
                text: root.activePlayer?.metadata?.artist ?? ""
                color: Colors.pillMuted
                font.pixelSize: 11
                font.family: "JetBrainsMono Nerd Font"
                elide: Text.ElideRight
            }
        }

        // ── Controls ──────────────────────────────────────────
        RowLayout {
            spacing: 2

            Repeater {
                model: [
                    { icon: "󰒮", action: function() { root.activePlayer?.previous() } },
                    { icon: root.activePlayer?.playbackState === MprisPlaybackState.Playing ? "󰏤" : "󰐊",
                      action: function() { root.activePlayer?.togglePlaying() } },
                    { icon: "󰒭", action: function() { root.activePlayer?.next() } }
                ]

                delegate: Text {
                    required property var modelData
                    text: modelData.icon
                    color: Colors.secondary
                    font.pixelSize: 16
                    font.family: "JetBrainsMono Nerd Font"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: modelData.action()
                    }
                }
            }
        }
    }
}
