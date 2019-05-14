import QtQuick 2.0
import "../"

Rectangle {
    width: 640; height: 480
    ComboBox {
        y: 10
        anchors.horizontalCenter: parent.horizontalCenter
        model: ["One", "Two", "Three", "Four", "Five"]
    }


//    MouseArea {
//        anchors.fill: parent
//        onClicked: animation.start()
//    }

//    Rectangle {
//        id: rect
//        width: 200; height: 0
//        color: "lightblue"
////        anchors.bottom: parent.bottom
//    }

//    NumberAnimation {
//        id: animation
//        target: rect
//        properties: "height";
//        easing.type: Easing.Linear;
//        from: 0
//        to: 200
//        duration: 1000
//    }
}
