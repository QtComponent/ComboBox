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
        id: d
        width: 200; height: 50
        color: delegateMouseArea.isEnter ? "red" : "blue"

        Text {
            anchors.centerIn: parent
            text: modelData
        }

        MouseArea {
            id: delegateMouseArea
            property bool isEnter: false
            anchors.fill: parent
            hoverEnabled: true
            onEntered: isEnter = true
            onExited: isEnter = false
            onClicked: {
                d.ListView.view.visible = false
                console.log(">>>>>>")
            }
        }
    }

    property Component indicator : Item {

    }

    property Component contentItem : Rectangle {
        width: 200; height: 50
//        color: ?"#bdbdbd" : "#e0e0e0"
        color: "#bdbdbd"
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
                onClicked: _listView.visible = !_listView.visible
            }
        }

        ListView {
            id: _listView
            width: contentItemId.width; height: contentItemId.height * 3
            visible: false
            delegate: root.delegate

            onVisibleChanged: {
                _listView.y = -100
            }

            NumberAnimation {
                target: _listView
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
//            onVisibleChanged: {
//                if (visible)
//                    listViewBackground.height = contentItemId.height * 3
//                else
//                    listViewBackground.height = 0
//            }
        }

//        Rectangle {
//            id: listViewBackground
//            width: contentItemId.width
//            height: 0
//            clip: true
//
//            Behavior on height {
//                NumberAnimation { duration: 200 }
//            }
//
//        }
    }

    /* Private */
    QtObject {
        id: _private
    }
}
