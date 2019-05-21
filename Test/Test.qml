import QtQuick 2.0
import "../" as My

Rectangle {
    width: 640; height: 480

    My.ComboBox {
        anchors.centerIn: parent
        model: ["One", "Two", "Three", "Four", "Five"]
    }
}

