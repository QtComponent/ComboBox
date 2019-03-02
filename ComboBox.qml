import QtQuick 2.0

Item {
    id: root
    implicitWidth: contentItemId.item.width
    implicitHeight: contentItemId.item.height

    property alias count: _listView.count // note: read-only
    property alias currentIndex: _listView.currentIndex
    property string currentText: "" // note: read-only
    property alias model: _listView.model
    property alias pressed: mouseArea.pressed

    property Component delegate: Rectangle {
        width: 200; height: 50
        color: "lightblue"
        Text {
            anchors.centerIn: parent
            text: modelData
        }
    }

    property Component indicator : Rectangle {
    }

    property Component contentItem : Rectangle {
        width: 200; height: 50
        color: pressed ?  "gray" : "lightgreen"
    }

    property Component background : Rectangle {
    }

    Loader {
        id: indicatorId
        sourceComponent: indicator
    }

    Loader {
        id: backgroundId
        sourceComponent: background
    }

    Column {
        Loader {
            id: contentItemId
            sourceComponent: contentItem

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onPressed: _private.isPopupList = !_private.isPopupList
            }
        }

        Rectangle {
            id: rect
            width: contentItemId.width
            height: 0
            Behavior on height {
                NumberAnimation { duration: 1000 }
            }

            ListView {
                id: _listView
                width: contentItemId.width; height: count * contentItemId.item.height
    //            visible: _private.isPopupList
                delegate: root.delegate

            }
            clip: true
        }
    }

    /* Private */
    QtObject {
        id: _private
        property bool isPopupList: false
        onIsPopupListChanged:
            if (isPopupList)
                rect.height = 300
            else
                rect.height = 0
    }
}
