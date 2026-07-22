import QtQuick

QtObject {
    id: app
    property var names: []
    property string icon

    property bool useTitle: {
        return alternateTitles.length > 0
    }

    property var alternateTitles: []
    property var alternateIcons: []
}