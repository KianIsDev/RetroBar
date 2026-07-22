import QtQuick.Layouts
import Quickshell
import QtQuick
import Quickshell.Hyprland
import Quickshell.Io


PanelWindow {

    property bool updateAvailable: false
    property int numberOfPackages: 0


    visible: showPowerBar
    anchors {
        top: true
        left: true
    }
    implicitWidth: 350
    implicitHeight: 50
    color: 'transparent'
    Rectangle {
        anchors.fill: parent
        bottomLeftRadius: 0
        bottomRightRadius: 15
        border.width: 1
        border.color: '#63412c5f'
        gradient: Gradient {
            GradientStop { position: -1.0; color: '#97311d4c' }
            GradientStop { position: 1.0; color: '#6e040e0d' }
        }
        RowLayout {
            anchors.centerIn: parent
            implicitHeight: parent.height
            //implicitWidth: parent.width
            spacing: parent.width / 6 - 20

            PowerBarButton { title: "Off"; icon: "0xf06a6";
            
                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                        Hyprland.dispatch("hl.dsp.exec_cmd( \"poweroff\" )")

                    }
                }
            }
            
            PowerBarButton { title: "Reboot"; icon: "0xf021";
            
                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                        Hyprland.dispatch("hl.dsp.exec_cmd( \"reboot\" )")

                    }
                }
            
            }
            

            PowerBarButton { title: updateAvailable ? (numberOfPackages) + " Packages" : "No Update" ; icon: updateAvailable ? "0xeac2" : "0xe302";
            
                id: updateButton

                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                        startUpdateProcess.running = true

                        if (updateAvailable) {
                            showPowerBar = false
                        }
                    }
                }
            
            }
            
            PowerBarButton { title: "Fun"; icon: "0xf1383" }

        }
    }

    Process {
        id: checkUpdateProcess
        running: true
        command: ["checkupdates"]
        stdout: StdioCollector {
            onStreamFinished: {
                var updates = this.text.trim()

                console.log("_" + updates)
                updateAvailable = updates != ""

                if (updateAvailable) {

                    var parts = updates.split('->')
                    numberOfPackages = parts.length - 1

                }
            }
        }
    }

    Process {
        id: startUpdateProcess
        command: ["checkupdates"]
        stdout: StdioCollector {
            onStreamFinished: {
                var updates = this.text.trim()

                console.log("_" + updates)
                updateAvailable = updates != ""

                if (updateAvailable) {

                    var parts = updates.split('->')
                    numberOfPackages = parts.length - 1

                    Hyprland.dispatch("hl.dsp.exec_cmd( \"kitty sh -c 'checkupdates; sudo yay -Syu; sleep 3'\" )")
                }
            }
        }
    }

}
