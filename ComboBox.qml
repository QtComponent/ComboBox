import QtQuick 2.0

Item {
    id: root

    property alias  currentIndex: _listView.currentIndex // type: int
    property string currentText: _listView.currentText // note: read-only
    property alias  model: _listView.model // type: listmodel
    property alias  pressed: mouseArea.pressed // type: bool
    property bool   down: false;
    property alias  count: _listView.count // type: int; note: read-only

    property Component delegate: _private.defaultDelegate
    property Component indicator: _private.defaultIndicator
    property Component contentItem: _private.defaultContentItem
    property Component background: _private.defaultBackground
    property Component popup: _private.defaultPopup

    implicitWidth: contentItemId.item.width
    implicitHeight: contentItemId.item.height

    Loader {
        id: indicatorId
        sourceComponent: indicator
    }

    Loader {
        id: backgroundId
        sourceComponent: background
    }

    Item {
        width: contentItemId.item.width
        height: contentItemId.item.height

        Loader {
            id: contentItemId
            sourceComponent: contentItem
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onReleased: root.down = !root.down
        }
    }

    Loader {
        id: popupId
        y: contentItemId.item.height
        sourceComponent: popup
        clip: true

        ListView {
            id: _listView
            property string currentText: ""

            anchors.fill: parent
            visible: root.down
            delegate: root.delegate
            onCurrentIndexChanged: currentText = model[currentIndex]
        }
    }

    /* Private */
    QtObject {
        id: _private
        property Component defaultDelegate: Rectangle {
            id: d
            width: 200; height: 50
            color: delegateMouseArea.isEnter || root.currentIndex === index ? "red" : "blue"

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
                    root.down = false
                    d.ListView.view.currentIndex = index
                }
            }
        }

        property Component defaultIndicator: Item { }

        property Component defaultContentItem: Rectangle {
            id: app
            width: 200; height: 50
            color: root.pressed ? "#bdbdbd" : "#e0e0e0"
            Text {
                text: root.currentText
            }
        }

        property Component defaultBackground: Item { }

        property Component defaultPopup: Item {
            width: root.width; height: root.height * 3
        }
    }
}
