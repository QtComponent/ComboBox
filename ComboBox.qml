import QtQuick 2.0

Item {


    property int count: 0
    property int currentIndex: 0
    property string currentText: ""
    property alias model: _listView.model
    property alias pressed: false

    property Component delegate: Rectangle { }

    property Component indicator : Rectangle {
    }

    property Component contentItem : Text {
    }

    property Component background : Rectangle {
    }

    ListView {
        id: _listView
    }
}
