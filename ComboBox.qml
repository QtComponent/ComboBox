/**********************************************************
Author: Qtbig哥
WeChat Official Accounts Platform: nicaixiaoxuesheng (文章首发)
Website: qtbig.com(后续更新)
Email:  2088201923@qq.com
QQ交流群: 732271126
LISCENSE: MIT
**********************************************************/
import QtQuick 2.0

Item {
    id: root

    property alias  currentIndex: _listView.currentIndex // type: int
    property string currentText:  _listView.currentText // note: read-only
    property alias  model:        _listView.model // type: listmodel
    property alias  pressed:      mouseArea.pressed // type: bool
    property bool   down:         false;
    property alias  count:        _listView.count // type: int; note: read-only

    property Component delegate:    _private.defaultDelegate
    property Component indicator:   _private.defaultIndicator
    property Component contentItem: _private.defaultContentItem
    property Component background:  _private.defaultBackground
    property Component popup:       _private.defaultPopup

    width: contentItemId.item.width
    height: contentItemId.item.height

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
        id: indicatorId
        sourceComponent: indicator
    }

    Loader {
        id: popupId
        y: contentItemId.item.height
        visible: root.down
        clip: true
        sourceComponent: popup

        ListView {
            id: _listView
            property string currentText: ""
            width:  popupId.item.width
            height: popupId.item.height
            clip: true
            delegate: root.delegate
            onCurrentIndexChanged: currentText = model[currentIndex]
        }
    }

    /* Private */
    QtObject {
        id: _private
        property Component defaultDelegate: Rectangle {
            width: 150; height: 40

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
                color: delegateMouseArea.isEnter ? "#4cbeff" : "black"
                text: modelData
                font.bold: true
                font.pixelSize: 17
            }

            Rectangle {
                id: line
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                width: parent.width*0.8
                height: 1
                color: "#e6e8ea"
                visible: index !== root.count - 1
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
                    root.currentIndex = index
                }
            }
        }

        property Component defaultIndicator: Item {
            width: root.width; height: root.height

            Item {
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 2
                anchors.right: parent.right
                anchors.rightMargin: 15
                clip: true
                width: 2*height; height: 7

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -parent.height/2
                    width: Math.sqrt(parent.width*parent.width*2)/2; height: width
                    color: root.down ? "white" : "#4cbeff"
                    rotation: 45
                }
            }
        }

        property Component defaultContentItem: Rectangle {
            width: 150; height: 40
            color: root.down ? "#4cbeff" : "white"
            border.width: root.down ? 0 : 1
            border.color: "#d5d5d5"


            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
                color: root.down ? "white" : "#333333"
                text: root.currentText
                font.bold: true
                font.pixelSize: 17
            }
        }

        property Component defaultBackground: Item { }

        property Component defaultPopup: Rectangle {
            width: root.width; height: root.height * 3
            color: "#00000000"
            border.color: "#d5d5d5"
        }
    }
}
