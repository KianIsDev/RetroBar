import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "root:/ClockModule"
import "root:/AudioModule"
import "root:/PowerModule"
import "root:/WorkspaceModule"

ShellRoot {

    property bool showPowerBar: false

    Variants {
        model: Quickshell.screens


        PanelWindow {
            id: barWindow
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 25



            color: '#df040e0d'

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                spacing: 10

                PowerButton { }

                Bar { }

                Workspaces { }   

                Item {
                    Layout.fillWidth: true
                }

                Audio { }

                //Battery { }

                Bar { }

                Clock { }
                

 
            }

            Component {
                id: blurComponent
                    
                MultiEffect {
                    blurEnabled: true
                    blur: barWindow.implicitHeight * 0.0005
                    brightness: 0.15
                }
            }
        }
    }

    PowerBar { }

    PopupBlocker { visible: showPowerBar;
    
        MouseArea {
            anchors.fill: parent
            onClicked: {
                showPowerBar = false
            }
        }

    }

}
