import Quickshell
import QtQuick

Text {
    text: String.fromCodePoint(0xf011)
    color: '#a489ca'
    font {
        family: "JetBrainsMono Nerd Font Propo"
        pixelSize: 15
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            showPowerBar = !showPowerBar
        }
    }

}

