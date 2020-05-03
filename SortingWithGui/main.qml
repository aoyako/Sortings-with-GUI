import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtQuick 2.0

Window {
    id: _all

    visible: true
    width: 640
    height: 480

    property int ind1: 0;
    property int ind2: 0;
    property string namEl1: "";
    property string namEl2: "";
    property int speed: 3;

    Timer {
        id: _actionTimerColor1
        interval: speed * 335
        running: false
        repeat: false
        onTriggered: _listModel.set(ind1, {col: "red"}), _listModel.set(ind2, {col: "red"})
    }
    Timer {
        id: _actionTimerName1
        interval: speed * 670
        running: false
        repeat: false
        onTriggered: _listModel.set(ind1, {textList: namEl2}), _listModel.set(ind2, {textList: namEl1})
    }
    Timer {
        id: _actionTimerColor3
        interval: speed * 1000
        running: false
        repeat: false
        onTriggered: _listModel.set(ind1, {col: "lightblue"}), _listModel.set(ind2, {col: "lightblue"})
    }

    Connections {
        target: sorting
        onSendToQml: {
            ind1 = id1;
            ind2 = id2;
            namEl1 = name1;
            namEl2 = name2;
            _actionTimerColor1.start()
            _actionTimerName1.start()
            _actionTimerColor3.start()
        }
    }

    RowLayout {
        id: _rowLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5
        height: 60

        spacing: 5
        z:2

        ComboBox {
            id: _sortingType


            Layout.fillHeight: true

            model: ["Selection Sort", "Bubble Sort", "QuickSort", "Insertion Sort", "Merge Sort", "HeapSort"]
        }


        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "grey"

            TextInput {
                id: _textInput
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                validator: RegExpValidator { regExp: /\d{1,4}(?:,\d{1,4})+$/ }

                font.pixelSize: 20

                Keys.onPressed: {
                    if(event.key === 16777220){
                        sorting.createArr(_textInput.text);
                        _listModel.append({ textList: _textInput.text, col: "lightblue" })
                    }
                }
            }
        }
        Button {
            id: _button
            text: qsTr("Add")
            Layout.fillHeight: true

            onClicked: {
                sorting.createArr(_textInput.text);
                _listModel.append({ textList: _textInput.text, col: "lightblue" })
            }
        }

        Button {
            id: _buttonStart
            text: qsTr("Start")
            Layout.fillHeight: true

            onClicked: {
                sorting.startSort(_sortingType.currentText);
            }
        }
    }

    RowLayout {
        id: _rowLayoutSpeed
        anchors.top: _rowLayout.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5
        height: 60

        anchors.topMargin: _rowLayout.height + 5

        spacing: 5
        z:2

        Button {
            id: _faster
            Layout.fillHeight: true
            text: "Faster"
            onClicked: {
                if (speed > 1){
                    speed--;
                }
            }
        }
        Button {
            id: _slower
            anchors.left: _faster.right
            Layout.fillHeight: true
            text: "Slower"
            onClicked: {
                if (speed < 20){
                    speed++;
                }
            }
        }
    }

    ListView {
        id: _listView

        anchors.top: _rowLayoutSpeed.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.topMargin: _rowLayout.height + _rowLayoutSpeed.height + 20

        spacing: 5
        orientation: ListView.Horizontal
        z: 1

        delegate: Rectangle {
            id: _elem

            width: 120
            height: 120
            color: col
            border.color: "black"
            border.width: 2
            radius: 5

            Text {
                anchors.centerIn: _elem
                font.bold: true
                font.pointSize: 20

                text: textList
            }
        }

        model: ListModel{
            id: _listModel
        }
    }
}
