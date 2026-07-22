import Quickshell
import Quickshell.Services.Pipewire 
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects


RowLayout {
    
    id: root
    spacing: 0.05 * innerVerticalheight
    layer.enabled: true
    layer.effect: blurComponent
    
    property var verticalMargin: innerVerticalheight * 0.8

    property var sink: Pipewire.defaultAudioSink
    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0

    readonly property string icon: {
        if (!ready) return String.fromCodePoint(0xEEE8)
        if (muted)  return String.fromCodePoint(0xF0e08)

        if (vol === 0)  return String.fromCodePoint(0xF0581)
        if (vol < 34)   return String.fromCodePoint(0xF057F)
        if (vol < 67)   return String.fromCodePoint(0xF0580)

                        return String.fromCodePoint(0xF057E)
    }

    Text {
        text: root.icon
        color: '#d9c5f5'

        Layout.minimumWidth: 0.8 * verticalMargin

        font {
            family: "JetBrainsMono Nerd Font Propo"
            pixelSize: verticalMargin
        }

        MouseArea {
            anchors.fill: parent
            onClicked: Hyprland.dispatch("hl.dsp.exec_cmd( \"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\" )")
        }
    }

    Text {
        text: {
            if (!root.ready)    return "-"

                return root.vol + "%"
        }
        
        color: root.muted || root.vol <= 0 ? '#91d9c5f5' : '#d9c5f5'

        Layout.minimumWidth: 2.7 * verticalMargin

        font {
            family: "SF Pro Display"
            weight: 400
            pixelSize: verticalMargin
        }

        
            
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.muted){
                    Hyprland.dispatch("hl.dsp.exec_cmd( \"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\" )")
           
                } else {
                    Hyprland.dispatch("hl.dsp.exec_cmd( \"flatpak run org.pulseaudio.pavucontrol\" )")

                }
            }
                
            onWheel: {
                if (wheel.angleDelta.y > 0) {
                    Hyprland.dispatch("hl.dsp.exec_cmd( \"wpctl set-volume @DEFAULT_AUDIO_SINK@ " + ( root.vol < 95 ? "5%+" : ( root.vol > 100 ? "100%" : ( root.vol == 100 ? "0%-" : "1%+"))) + "\" )")
                }
                else {
                    Hyprland.dispatch("hl.dsp.exec_cmd( \"wpctl set-volume @DEFAULT_AUDIO_SINK@ " + (root.vol <= 95 ? "5%-" : "95%") + "\" )")
                }
            
            }

        }
        
    }

    PwObjectTracker {
        objects: [root.sink]
    }
}