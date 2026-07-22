import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

RowLayout {

    id: root
    spacing: 6

    property var battery: UPower.displayDevice
    property bool charging: battery.state === UPowerDeviceState.Charging
    readonly property int level: Math.round(battery.percentage * 100)

    readonly property string icon: {
        if (charging)       return String.fromCodePoint(0xF0084)
        if (level >= 100)   return String.fromCodePoint(0xF0079)
        if (level < 10)     return String.fromCodePoint(0xF0083)
                            return String.fromCodePoint(0xF007A + Math.Floor(level / 10) - 1)
    }

    Text {
        text: root.icon
        color: root.charging ? '#57d579'
                             : root.level <= 15 ? '#dc379f'
                             : root.level <= 30 ? '#e1ca47'
                             : '#57d579'

        font {
            family: "JetBrainsMono Nerd Font Propo"
            pixelSize: 10
        }
    }

    Text {
        text: root.level + "%"
        color: '#d9c5f5'

        font {
            family: "SF Pro Display"
            weight: 400
        }
    }

}