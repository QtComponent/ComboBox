import QtQuick 2.12
import QtQuick.Controls 2.12
import "../" as My
import "./"

Rectangle {
    width: 640; height: 480

    Row {
        anchors.centerIn: parent
        spacing: 100


        My.ComboBox {
            model: ["One", "Two", "Three", "Four", "Five"]
        }

        My.ComboBox {
            id: control
            model: ["One", "Two", "Three", "Four", "Five"]

            background: Item { }

            contentItem: RoundRectangle {
                width: 200; height: 50
                color: control.down ? "#4cbeff" : "white"
                radius: 8
                radiusCorners: control.down ? (Qt.AlignLeft | Qt.AlignRight | Qt.AlignTop) :
                                               (Qt.AlignLeading | Qt.AlignRight | Qt.AlignTop | Qt.AlignBottom)

                border.color: control.down ? "#00000000" : "#d5d5d5"

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    color: control.down ? "white" : "#333333"
                    text: control.currentText
                    font.bold: true
                    font.pixelSize: 17
                }
            }

            indicator: Item {
                width: control.width; height: control.height

                Item {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    width: Math.sqrt(_triangle.width*_triangle.width*2); height: width/2
                    clip: true

                    Rectangle {
                        id: _triangle
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: parent.height/4
                        width: 12; height: width
                        color: control.down ? "white" : "#4cbeff"
                        rotation: 45
                    }
                }
            }

            delegate: Rectangle {
                width: 200; height: 50

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
                    visible: index !== control.count - 1
                }

                MouseArea {
                    id: delegateMouseArea
                    property bool isEnter: false
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: isEnter = true
                    onExited: isEnter = false
                    onClicked: {
                        control.down = false
                        control.currentIndex = index
                    }
                }
            }

            popup: Rectangle {
                width: control.width; height: control.height * 3
                color: "#00000000"
                border.color: "#d5d5d5"
            }
        }
    }
}

