import Quickshell
import Quickshell.Services.Pipewire 
import Quickshell.Hyprland
import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import QtQuick.Effects

RowLayout {
            spacing: 0

            Repeater {
                model: 3

                Text {
                    required property int index

                    text: {
                        if (!root.ready) {
                            return "-"
                        }

                        var numbers = "000" + root.volume + ""

                        return numbers[numbers.length - 3 + index]
                    }
                    
                    //color: root.muted || root.volume <= 0 ? '#91d9c5f5' : '#d9c5f5'
                    color: root.muted || root.volume < Math.pow(10, 2 - index)  ? '#78d9c5f5' : '#d9c5f5'

                    //Layout.minimumWidth: 0.7 * innerVerticalheight

                    font {
                        family: "SF Pro Display"
                        weight: 400
                        pixelSize: 0.7 * innerVerticalheight
                    }
                    
                }
            }
        }