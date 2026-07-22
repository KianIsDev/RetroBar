import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: audioFrame

    property var outerHorizontalMargin: (0.15 * height)
    property var innerVerticalheight: height - (0.1 * height)
    property var rowSpacing: (0.1 * height)


    color: '#55555588'
    implicitWidth: (displayFrame.implicitWidth) + outerHorizontalMargin * 2
    implicitHeight: parent.height - (0.1 * parent.height)
    radius: (0.1 * parent.height)

    Rectangle {
        
        id: displayFrame
        color: '#111111'

        y: parent.height / 2 - implicitHeight / 2
        x: parent.implicitWidth / 2 - implicitWidth / 2
        
        implicitWidth: (audioLayout.implicitWidth) + outerHorizontalMargin * 2
        radius: (0.3 * innerVerticalheight)
        implicitHeight: innerVerticalheight

        RowLayout {
            id: audioLayout
            
            x: outerHorizontalMargin
            y: parent.height / 2 - implicitHeight / 2

            spacing: rowSpacing

            Volume { }

            Media { }
    
        }


    }
}
