import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

Rectangle {
    property var verticalSpacing: innerVerticalheight * 0.06 + 2
    property var numberOfTicks: 4
    property var scrollerWidth: innerVerticalheight * 0.22
    property var myClock: SystemClock { precision: SystemClock.Seconds}
    property var secondsProgress: myClock.seconds

    implicitHeight: innerVerticalheight
    implicitWidth: scrollerWidth
    color: '#38000000'
    radius: (0.1 * innerVerticalheight)

    

    ColumnLayout {
        spacing: verticalSpacing
        anchors.centerIn: parent

        Repeater {
            model: numberOfTicks

            Rectangle {
                required property int index

                implicitWidth: scrollerWidth
                implicitHeight: ((innerVerticalheight - verticalSpacing * (numberOfTicks)) / numberOfTicks)
                
                layer.enabled: true
                layer.effect: blurComponent
            
                radius: (0.2 * innerVerticalheight)

                Component {
                    id: blurComponent
                    
                    MultiEffect {
                        blurEnabled: true
                        blur: innerVerticalheight * 0.0008
                    }
                }

                color: {
                    if(secondsProgress >= 59) return '#ad93fa'
                    if(secondsProgress + 1 <= (index + 1) * (60 / numberOfTicks)) return '#111111'
                    return '#d9c5f5'
                }

            }
        }
    }
}

