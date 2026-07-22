import Quickshell
import QtQuick

Rectangle {
    implicitWidth: 1
    implicitHeight: parent.height - (0.2 * parent.height)

    gradient: Gradient {
        GradientStop { position: 0; color: '#259d5bfa' }
        GradientStop { position: 0.5; color: '#8d9d5bfa' }
        GradientStop { position: 1; color: '#259d5bfa' }
    }
}
