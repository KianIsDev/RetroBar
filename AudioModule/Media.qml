import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire 
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts




RowLayout {

    Layout.fillHeight: true
    implicitHeight: parent.height

    property var artist: ""
    property var title: ""
    property var imageSource: ""
    property bool isPlaying: false

    spacing: 0.11 * innerVerticalheight

    Rectangle {

        visible: imageSource !== ""

        implicitWidth: 1.2 * innerVerticalheight
        implicitHeight: 0.9 * innerVerticalheight

        Layout.alignment: Qt.AlignBaseline

        color:'#00000000'

        border.width: isPlaying ? 2 : 1
        border.color: isPlaying ? '#d9c5f5' : '#36a183cb'

        Image {
            //visible: imageSource !== ""

            opacity: isPlaying ? 0.7 : 0.3

            anchors.fill: parent

            fillMode: Image.PreserveAspectCrop 
            source: imageSource

            Text {
                anchors.centerIn: parent

                text: String.fromCodePoint(0xede9)
                color: mouse.hovered ? '#ffffff' : '#00000000'

                opacity: 1

                font {
                    family: "JetBrainsMono Nerd Font Propo"
                    pixelSize: 0.9 * innerVerticalheight
                }
            }

        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                Hyprland.dispatch("hl.dsp.exec_cmd( \"playerctl play-pause\" )")
            }
        }

        HoverHandler {
            id: mouse
            acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
            cursorShape: Qt.PointingHandCursor
        }
    }



    ColumnLayout {

        spacing: -0.19 * innerVerticalheight

        Text {

            //visible: isPlaying
            id: titleText

            text: {
                var titleTrim = title.substring(0,20)
                if (title === titleTrim){
                    return title
                }
                return titleTrim.trim() + "..."
            }

            color: '#d9c5f5'

            opacity: isPlaying ? 1 : 0.8

            font {
                family: "SF Pro Display"
                weight: 400
                pixelSize: 0.48 * innerVerticalheight
            }
        }

        Text {
    
            //visible: isPlaying
            id: artistText

            text: {
                var artistTrim = artist.substring(0,20)
                if (artist === artistTrim){
                    return artist
                }
                return artistTrim.trim() + "..."
            }

            color: '#d9c5f5'

            opacity: isPlaying ? 0.8 : 0.3

            font {
                family: "SF Pro Display"
                weight: 400
                pixelSize: 0.45 * innerVerticalheight
            }

        }


    }

    Process {
        id: mediaProcess
        running: true
        //playerctl
        command: ["playerctl", "metadata", "--format", "{{title}}\\spacerPlaceholder\\{{artist}}\\spacerPlaceholder\\{{mpris:artUrl}}"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) {
                    playing = "no data!"
                    return
                }
                var parts = data.trim().split('\\spacerPlaceholder\\')
                title = parts[0] || "unknown station"
                artist = parts[1] || "---"
                imageSource = parts[2] || ""
            }
        }
        //Component.onCompleted: running = true
    }

    Process {
        id: statusProcess
        running: true
        //playerctl
        command: ["playerctl", "status"]
        stdout: StdioCollector {
            onStreamFinished: {
                isPlaying = this.text.trim() === "Playing"
                //console.log(`line read: ${"_" + this.text.trim() + "_" + isPlaying}`)
            }
        }
        //Component.onCompleted: running = true
    }

    Timer {
        interval: 7000
        running: true
        repeat: true
        onTriggered: {
            mediaProcess.running = true
            statusProcess.running = true
        }
    }
}







/*
Repeater {
    model: Pipewire.ready ? Pipewire.nodes : null

    delegate: Text {

        readonly property bool isValidStream: modelData && modelData.isStream

        required property PwNode modelData

        PwObjectTracker {
            objects: isValidStream ? [modelData] : []
        }

        visible: isValidStream
        color: '#ffffff'
        text: !isValidStream ? "" : " _" + modelData.properties["media.name"] + " " + modelData.name


    }
}

*/


/*
Text {
    id: mediaDisplay

    property var pw: Quickshell.Services.Pipewire

    text: Pipewire.defaultAudioSink.audio.volume + "."
    color: '#d9c5f5'

    font {
        family: "SF Mono"
        letterSpacing: -1
        pixelSize: innerVerticalheight * 0.7
        weight: 300
    }
    
    //PwObjectTracker {
    //    objects: [mediaDisplay.sink]
    //}
}


*/