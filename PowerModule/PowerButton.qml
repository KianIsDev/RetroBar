import Quickshell
import QtQuick

Text {
    text: String.fromCodePoint(0xf011)
    color: '#a489ca'

    layer.enabled: true
    layer.effect: blurComponent

    font {
        family: "JetBrainsMono Nerd Font Propo"
        pixelSize: 0.65 * parent.height
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            showPowerBar = !showPowerBar
        }
    }

}

