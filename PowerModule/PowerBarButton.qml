import QtQuick.Layouts
import QtQuick


Rectangle {

    property string title: ""
    property string icon: ""

    implicitHeight: parent.height
    implicitWidth: parent.height
    color: '#23000000'
    ColumnLayout {
        spacing: -8
        anchors.centerIn: parent
        Text {
            Layout.alignment: Qt.AlignCenter
            text: String.fromCodePoint(icon)
            color: '#d9c5f5'
            font {
                family: "JetBrainsMono Nerd Font Propo"
                pixelSize: 30
            }
        }
        Text {
            text: title
            color: '#d9c5f5'
            Layout.alignment: Qt.AlignCenter


            font {
                family: "JetBrainsMono Nerd Font Propo"
                pixelSize: 10
                wordSpacing: -5

            }
        }
    }
}