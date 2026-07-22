import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {

    // ---------------------------------
    // For debugging workspaces when adding new apps
       property bool debugApps: false
    // icons at: https://www.nerdfonts.com/cheat-sheet
    // run command: qs -p .config/quickshell/RetroBar
    // ---------------------------------



    implicitHeight: parent.height

    property var innerVerticalheight: height - (0.015 * height)


    spacing: 0.25 * innerVerticalheight

    id: lay
    property var monitors: Hyprland.monitors.values
    property var workspaces: Hyprland.workspaces.values
    property int focusedWorkspace: Hyprland.focusedWorkspace?.id || 0

    property list<QtObject> prioritizedApps: [
        AppIcon {
            names: [ "" ]; icon: "";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "kitty" ]; icon: "0xf018d";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "gnome" ]; icon: "0xf08c6";
            alternateTitles: [ "Calculator", "Clocks" ]
            alternateIcons: [ "0xf0a9a", "0xf0954" ]
        }, AppIcon {
            names: [ "appimagepool" ]; icon: "0xf0730";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "prismlauncher" ]; icon: "0xf01a7";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "code-oss" ]; icon: "0xf0a1e";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "steam" ]; icon: "0xf1b6";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "firefox" ]; icon: "0xf0239";
            alternateTitles: [ "Picture-in-Picture" ]
            alternateIcons: [ "0xf0ecf" ]
        }, AppIcon {
            names: [ "spotify" ]; icon: "0xf1bc";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "vencord", "vesktop", "discord" ]; icon: "0xf1ff";
            alternateTitles: []
            alternateIcons: []
        },AppIcon {
            names: [ "usebottles", "bottles" ]; icon: "0xf0854";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "vlc" ]; icon: "0xf057c";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "jetbrains-rider" ]; icon: "0xe88f";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "Creality" ]; icon: "0xf0e5b";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "orca-slicer" ]; icon: "0xee41";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "bitwig" ]; icon: "0xf001";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "krita" ]; icon: "0xf33d";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "steam_app" ]; icon: "0xf05ba";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "minecraft" ]; icon: "0xf0373";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "inkscape" ]; icon: "0xe801";
            alternateTitles: []
            alternateIcons: []
        }, AppIcon {
            names: [ "blender" ]; icon: "0xf00ab";
            alternateTitles: []
            alternateIcons: []
        },
    
    ]

    property list<string> workspaceIcons
    property list<int> workspaceIconPriorities

    Rectangle {
        implicitHeight: innerVerticalheight
        implicitWidth: 0.5 * innerVerticalheight
        radius: 0.2 * innerVerticalheight
        color: '#44323232'
        Text {
            anchors.centerIn: parent
            color: '#999999'
            text: "+"
            font {
                family: "JetBrainsMono Nerd Font Propo"
                weight: 200
                pixelSize: 0.6 * innerVerticalheight
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                
                var smallestAvailable = 10000

                for (var i = 1; i < 10000; i++) {

                    var match = false

                    for (var ii = 0; ii < lay.workspaces.length; ii++) {
                        
                        if (lay.workspaces[ii].id == i) {
                            match = true
                            break;
                        }
                    }

                    if (!match) {
                        smallestAvailable = i
                        break;
                    }

                }

                Hyprland.dispatch("hl.dsp.focus({ workspace = " + (smallestAvailable) + " })")

                workspaceIconProcess.running = true


            }
        }
    }

    Repeater {
        model: lay.monitors

        RowLayout {
            spacing: -0.01 * innerVerticalheight

            id: monitorId

            required property int index

            Text {
                visible: lay.monitors.length > 1
                text: String.fromCodePoint(0xf0379)
                color: '#d9c5f5'
                font {
                    family: "JetBrainsMono Nerd Font Propo"
                    pixelSize: 0.36 * innerVerticalheight
                }
            }

            Text {
                visible: lay.monitors.length > 1

                color: '#ffffff'
                text: (index + 1) //workspaces[0].active  //monitors[0].activeWorkspace.id

                font {
                    family: "JetBrainsMono Nerd Font Propo"
                    pixelSize: 0.36 * innerVerticalheight
                }
            }

            Item {
                implicitWidth: 0.12 * innerVerticalheight
            }


            RowLayout {
                
                spacing: 0.08 * innerVerticalheight
                    
                Repeater {
                    model: lay.workspaces
                    
                    Rectangle {
                        id: workspaceId

                        required property int index

                        property var actualWorkspace: lay.workspaces[index]

                        property bool isActive: actualWorkspace.active
                        property bool isFocused: focusedWorkspace == actualWorkspace.id

                        visible: actualWorkspace.monitor != null ? actualWorkspace.monitor.id == monitorId.index : false

                        implicitHeight: 0.82 * innerVerticalheight
                        implicitWidth: 1.4 * innerVerticalheight
                        radius: 0.24 * innerVerticalheight

                        border.width: 1
                        border.color: '#63b38aed'

                        color: isActive ? (isFocused ? '#71aa78ef' : '#40aa78ef' ) : '#17ffffff'

                        RowLayout {
                            spacing: 1
                            anchors.centerIn: parent

                            Text {
                                id: lable
                            
                                text: String.fromCodePoint(workspaceIcons[workspaceId.actualWorkspace.id] || "0xef26")

                                color: workspaceId.isActive ? '#c59bff' : "#ffffff"

                                font {
                                    family: "SF Mono"
                                    pixelSize: 0.7 * innerVerticalheight
                                    weight: 500
                                }
                            }

                            Text {

                                text: workspaceId.actualWorkspace.id

                                opacity: 0.5

                                color: workspaceId.isActive ? '#c59bff' : "#ffffff"

                                font {
                                    family: "SF Mono"
                                    pixelSize: 0.44 * innerVerticalheight
                                    weight: 500
                                }
                            }

                        }




                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (actualWorkspace.id) + " })")
                            
                        }

                    }

                }
                
            }

        }

    }

    
    Process {
        id:workspaceIconProcess
        running: true
        command: [ "hyprctl", "clients" ]
        stdout: StdioCollector {
            onStreamFinished: {
                
                var length = 3
                for (var i = 0; i < lay.workspaces.length; i++) {
                    
                    if (lay.workspaces[i].id > length){
                        length = lay.workspaces[i].id
                    }

                }

                workspaceIcons.length = 0
                workspaceIcons.length = length + 1
                workspaceIconPriorities.length = 0
                workspaceIconPriorities.length = length + 1

                var parts = this.text.split('Window ')

                for (var i = 1; i < parts.length; i++) {

                    //console.log(parts[i].substring(parts[i].indexOf("class:") + 7, parts[i].indexOf("title:") - 2))
                    var appName = parts[i].substring(parts[i].indexOf("class:") + 7, parts[i].indexOf("title:") - 2)
                    var title = parts[i].substring(parts[i].indexOf("title:") + 7, parts[i].indexOf("initialClass:") - 2).trim()
                    var occupiedWorkspaceString = parts[i].substring(parts[i].indexOf("workspace:") + 11)
                    occupiedWorkspaceString = occupiedWorkspaceString.substring(0, occupiedWorkspaceString.indexOf(' ')).trim()
                    
                    var occupiedWorkspace = parseInt(occupiedWorkspaceString) || -1

                    if (occupiedWorkspace == -1){
                        continue;
                    }

                    if (appName.indexOf("inecraft") != -1) {
                        appName = "minecraft"
                    }

                    if (appName.indexOf("steam_app") != -1) {
                        appName = "steam_app"
                    }

                    if (appName.indexOf("org.") != -1 || appName.indexOf("com.") != -1) {
                        appName = appName.substring(appName.indexOf(".") + 1)
                        appName = appName.substring(0, appName.indexOf("."))
                    }
                    
                    for (var j = 0; j < prioritizedApps.length; j++) {

                        for (var k = 0; k < prioritizedApps[j].names.length; k++) {
                            
                            if ( prioritizedApps[j].names[k] == appName ) {

                                if ( j == 0 ) {
                                    break;
                                }

                                if (j < workspaceIconPriorities[occupiedWorkspace]) {
                                    break;
                                }

                                
                                var foundTitle = false

                                if ( prioritizedApps[j].useTitle ) {

                                    for (var l = 0; l < prioritizedApps[j].alternateTitles.length; l++) {
                                        
                                        if (title == prioritizedApps[j].alternateTitles[l]) {
                                            foundTitle = true
                                            workspaceIcons[occupiedWorkspace] = prioritizedApps[j].alternateIcons[l]
                                            workspaceIconPriorities[occupiedWorkspace] = j + 1
                                            break;
                                        }
                                        
                                    }

                                }

                                if ( foundTitle )
                                    break;
                                
                                workspaceIcons[occupiedWorkspace] = prioritizedApps[j].icon
                                workspaceIconPriorities[occupiedWorkspace] = j

                            
                            }

                        }

                    }

                    if (debugApps)
                        console.log(appName + "_" + occupiedWorkspace + "_" + title)
                }
                if (debugApps)
                        console.log("")

                //console.log(prioritizedAppsTest[0].useTitle)
                
                
            }
        }
    }


    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: {
            workspaceIconProcess.running = true
        }
    }



}


/*
    Process {
        id: mediaProcess
        //playerctl
        command: [ "hyprctl", "clients" ]
        stdout: SplitParser {
            onRead: data => {
                if (!data) {
                    playing = "no data!"
                    return
                }
                var parts = data.trim().split('\\spacerPlaceholder\\')
                title = parts[0] || "unknown"
                artist = parts[1] || "unknown"
                imageSource = parts[2] || ""
            }
        }
        Component.onCompleted: running = true
    }
*/

    /*
    Repeater {
        model: lay.workspaces

        Rectangle {
            id: wsButton
            required property int index

            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

            implicitWidth: lable.implicitWidth + 12
            implicitHeight: 18
            radius: 6

            color: isActive ? '#40aa78ef' : (ws ? '#17ffffff' : '#0fa319ff')

            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            visible: ws && lay.workspaces[index].monitor.id === 0

            Text {
                id: lable

                anchors.centerIn: parent
                text: wsButton.index + 1
                color: wsButton.isActive ? '#aa78ef' : (wsButton.ws ? "#ffffff" : "transparent")

                font {
                    family: "SF Mono"
                    pixelSize: 10
                    weight: 500
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (parent.index + 1) + " })")
                
            }

        }
    }

    Text {
        color: '#ffffff'
        text: "Monitor 2:" //workspaces[0].active  //monitors[0].activeWorkspace.id
    }

    Repeater {
        model: 9

        Rectangle {
            id: wsButton
            required property int index

            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

            implicitWidth: lable.implicitWidth + 12
            implicitHeight: 18
            radius: 6

            color: isActive ? '#40aa78ef' : (ws ? '#17ffffff' : '#0fa319ff')

            Behavior on color {
                ColorAnimation { duration: 150 }
            }
            
            visible: true //ws && lay.workspaces[index].monitor.id === 1

            Text {
                id: lable


                anchors.centerIn: parent
                text: wsButton.index + 1
                color: wsButton.isActive ? '#aa78ef' : (wsButton.ws ? "#ffffff" : "transparent")

                font {
                    family: "SF Mono"
                    pixelSize: 10
                    weight: 500
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (parent.index + 1) + " })")
                
            }

        }
    }
    */
