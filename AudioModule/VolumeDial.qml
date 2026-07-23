import Quickshell
import Quickshell.Services.Pipewire 
import Quickshell.Hyprland
import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import QtQuick.Effects


Rectangle {

    id: volumeDialRoot

    property int minRotation: -70
    property int maxRotation: 250
    property int numberOfDots: 15

    property int minHue: 45
    property int maxHue: -2


    implicitWidth: innerVerticalheight
    implicitHeight: parent.height

    color: '#00000000'



    RowLayout {
        
        anchors.fill: parent

        implicitHeight: parent.height
        implicitWidth: parent.height

        Rectangle {
            implicitHeight: innerVerticalheight
            implicitWidth: innerVerticalheight

            Layout.minimumWidth: innerVerticalheight

            color: '#00000000'


            Row {
                anchors.centerIn: parent

                spacing: -0.043 * innerVerticalheight

                /*
                Text {
                    id: dialEdge

                    text: String.fromCodePoint(0xf4aa)
                    color: '#d9c5f5'

                    font {
                        family: "JetBrainsMono Nerd Font Propo"
                        pixelSize: 0.6 * innerVerticalheight
                    }

                    Text {

                        id: dial
                        //anchors.centerIn: parent
                        
                        Layout.alignment: Qt.AlignCenter

                        x: parent.height / 2 - height / 2 + (muted ? 0.019 * parent.height : 0.011 * innerVerticalheight)
                        y: parent.width / 2 - width / 2 - (muted ? 0.012 * innerVerticalheight : 0.015 * innerVerticalheight)

                        text: String.fromCodePoint( muted ? 0xf28d : 0xf111)
                        color: muted ? '#b4a3cc' : '#d9c5f5'

                        //Layout.minimumWidth: 0.8 * verticalMargin

                        font {
                            family: "JetBrainsMono Nerd Font Propo"
                            pixelSize: 0.61 * innerVerticalheight
                        }

                        transform: Rotation {
                            id: dialRotation
                            angle: muted ? 0 : minRotation + (maxRotation - minRotation) / 100 * volume
                            origin.x: dial.width / 2
                            origin.y: dial.height / 2
                        }

                        Rectangle {
                            id: indicatordot

                            visible: !muted

                            x: 0.08 * innerVerticalheight
                            y: parent.height / 2 - height / 2

                            radius: 5

                            implicitHeight: 0.06 * innerVerticalheight
                            implicitWidth: 0.13 * innerVerticalheight
                            color: '#000000'
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch("hl.dsp.exec_cmd( \"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\" )")
                        }
                    }

                }
                */

                Rectangle {
                    id: dialEdge

                    color: '#b4a3cc'

                    radius: 100 * innerVerticalheight

                    implicitHeight: 0.6 * innerVerticalheight
                    implicitWidth: 0.6 * innerVerticalheight

                    Rectangle {
                        id: dial
                        anchors.centerIn: parent
                        
                        Layout.alignment: Qt.AlignCenter

                        
                        color: muted ? '#b4a3cc' : '#3c3453'

                        //Layout.minimumWidth: 0.8 * verticalMargin

                        radius: 100 * innerVerticalheight
                        implicitHeight: 0.53 * innerVerticalheight
                        implicitWidth: 0.53 * innerVerticalheight

                        transform: Rotation {
                            id: dialRotation
                            angle: muted ? 0 : minRotation + (maxRotation - minRotation) / 100 * volume
                            origin.x: dial.width / 2
                            origin.y: dial.height / 2
                        }

                        GridLayout {
                            anchors.fill: parent

                            columns: 0

                            Rectangle {
                                id: indicatordot

                                visible: !muted

                                x: 0.08 * innerVerticalheight
                                y: parent.height / 2 - height / 2

                                radius: 5

                                implicitHeight: 0.06 * innerVerticalheight
                                implicitWidth: 0.13 * innerVerticalheight
                                color: '#ffffff'
                            }

                            Text {

                                visible: muted

                                x: parent.width / 2 - width / 2
                                y: parent.height / 2 - height / 2 + 0.01 * parent.height

                                text: String.fromCodePoint(0xf075f)
                                color: '#3c3453'

                                font {
                                    family: "JetBrainsMono Nerd Font Propo"
                                    pixelSize: 0.6 * innerVerticalheight
                                }
                            }
                        }



                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch("hl.dsp.exec_cmd( \"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\" )")
                        }
                    }

                }
                


                Repeater {
                    model: numberOfDots

                    Rectangle {
                        id: dot

                        required property int index
                        //anchors.centerIn: parent
                        //Layout.alignment: Qt.AlignCenter

                        x: parent.width / 2
                        y: parent.height / 2 - 0.013 * innerVerticalheight

                        implicitWidth: 0.04 * innerVerticalheight
                        implicitHeight: 0.04 * innerVerticalheight

                        color: '#00000000'

                        //Layout.minimumWidth: 0.8 * verticalMargin

                        transform: Rotation {
                            id: dotRotation
                            angle: minRotation + (maxRotation - minRotation) / numberOfDots * (index) + (maxRotation - minRotation) / numberOfDots / 2
                            origin.x: dot.width / 2
                            origin.y: dot.height / 2
                        }

                        Text {

                            id: incrementDots

                            x: -0.44 * innerVerticalheight
                            y: -0.23 * innerVerticalheight

                            text: String.fromCodePoint(0xf09df)
                            color: muted ? '#ffffff' : ( (numberOfDots) / 100 * volume <= index) ? '#ffffff' : Qt.hsva((minHue - index * (minHue - maxHue) / numberOfDots ) / 100, 1.0, 1.0);
                            
                            font {
                                family: "JetBrainsMono Nerd Font Propo"
                                pixelSize: 0.4 * innerVerticalheight
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch("hl.dsp.exec_cmd( \"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\" )")
                        }
                    }
                }



            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Hyprland.dispatch("hl.dsp.exec_cmd( \"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\" )")
                }
                onWheel: {
                    if (wheel.angleDelta.y > 0) {

                        if (muted) {
                            Hyprland.dispatch("hl.dsp.exec_cmd( \"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\" )")
                        }
                        else

                        Hyprland.dispatch("hl.dsp.exec_cmd( \"wpctl set-volume @DEFAULT_AUDIO_SINK@ " + ( root.volume < 95 ? "5%+" : ( root.volume > 100 ? "100%" : ( root.volume == 100 ? "0%-" : "1%+"))) + "\" )")
                    }
                    else {
                        Hyprland.dispatch("hl.dsp.exec_cmd( \"wpctl set-volume @DEFAULT_AUDIO_SINK@ " + (root.volume <= 95 ? "5%-" : "95%") + "\" )")
                    }
                }
            }

        }

    }


}
