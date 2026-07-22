import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

Rectangle {
    
    id: digitsBlock
    color: '#111111'

    property var clockFormat: "mm"
    property var verticalMargin: (0.9 * innerVerticalheight)
    property var horizontalMargin: (0.75 * innerVerticalheight) * clockFormat.length
    property var fontHeightCorrection: (0.03 * innerVerticalheight)
    property var fontWeight: 580
    property var myClock: SystemClock { precision: SystemClock.Minutes}


    implicitWidth: horizontalMargin
    radius: (0.3 * innerVerticalheight)
    implicitHeight: innerVerticalheight
    // x: (0.15 * parent.height )
    // y: parent.height / 2 - (firstDigits.height) / 2

    Text {

        id: digitsBlockText
        text: Qt.formatDateTime(myClock.date, clockFormat).toUpperCase()
        color: '#d9c4f5'

        layer.enabled: false
        layer.effect: blurComponent
        //anchors.centerIn: parent

        y: innerVerticalheight / 2 - implicitHeight / 2 - fontHeightCorrection
        x: parent.implicitWidth / 2 - implicitWidth / 2

        font {
            family: "SF Mono"
            letterSpacing: -1
            pixelSize: verticalMargin
            weight: fontWeight
        }

       

        Behavior on text {
            
            PropertyAnimation {
                id: animateFlip
                target: flipLine
                properties: "implicitHeight"
                from: implicitHeight / 2 - 0.1 * innerVerticalheight
                to: 1
                duration: 50
            }
        }

        Rectangle {
            
            id: flipLine
            color: '#111111'
            opacity: .6
            implicitWidth: parent.implicitWidth
            implicitHeight: 1

            y: (parent.implicitHeight / 2 - implicitHeight)

        }

    }
}