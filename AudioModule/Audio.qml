import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire 
import Quickshell.Hyprland
import "root:"

Rectangle {
    id: root

    property var sink: Pipewire.defaultAudioSink
    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int volume: ready ? Math.round(sink.audio.volume * 100) : 0

    property var outerHorizontalMargin: (0.15 * height)
    property var innerVerticalheight: height - (0.1 * height)
    property var rowSpacing: (0.2 * height)


    color: '#55555588'
    implicitWidth: (displayFrame.implicitWidth) + outerHorizontalMargin * 2
    implicitHeight: parent.height - (0.1 * parent.height)
    radius: (0.1 * parent.height)


    RowLayout {
        id: displayFrame

        anchors.fill: parent
        
        spacing: 2

        Item { }

        VolumeDial { }

        Rectangle {
            
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


                VolumeText { }

                //Volume { }

                Media { }

        
            }


        }
    }

    PwObjectTracker {
        objects: [root.sink]
    }
}
