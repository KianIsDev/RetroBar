import QtQuick.Layouts
import Quickshell
import QtQuick

PanelWindow {

    visible: visibleBool

    color: '#00000000'
    implicitWidth: Quickshell.screens[0].width
    implicitHeight: Quickshell.screens[0].height
    anchors {
        top: true
        left: true
    }

}