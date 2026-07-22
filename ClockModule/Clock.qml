import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: clockFrame

    property var outerHorizontalMargin: (0.15 * height)
    property var innerVerticalheight: height - (0.1 * height)
    property var rowSpacing: (0.15 * height)


    color: '#55555588'
    implicitWidth: (clockLayout.implicitWidth) + outerHorizontalMargin * 2
    implicitHeight: parent.height - (0.1 * parent.height)
    radius: (0.1 * parent.height)

    RowLayout {
        id: clockLayout
        x: outerHorizontalMargin
        y: parent.height / 2 - (innerVerticalheight) / 2

        spacing: rowSpacing

        DigitBlock {
            clockFormat: "hh"
            myClock: clock
        }
    
        DigitBlock {
            clockFormat: "mm"
            myClock: clock
        }

        DigitScroller {
            myClock: clock
        }

        Item {
            
        }


        DigitBlock {
            clockFormat: "ddd"
            myClock: clock
        }
        
        DigitBlock {
            clockFormat: "dd"
            myClock: clock
        }

        DigitBlock {
            clockFormat: "MMM"
            myClock: clock
        }
 
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
        //animateRectangle.start()
    }
}
