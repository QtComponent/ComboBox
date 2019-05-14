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
        Text {
            anchors.centerIn: parent
            text: modelData
        }
    }

    property Component indicator : Rectangle {
    }

    property Component contentItem : Rectangle {
        width: 200; height: 50
        color: _private.isPopupList ?  "#bdbdbd" : "#e0e0e0"
    }

    property Component background : Rectangle {
        width: contentItemId.width; height: contentItemId.height*3
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
                NumberAnimation { duration: 200 }
            }

            ListView {
                id: _listView
                width: backgroundId.width; height: backgroundId.height
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
                rect.height = backgroundId.height
            else
                rect.height = 0
    }
}
