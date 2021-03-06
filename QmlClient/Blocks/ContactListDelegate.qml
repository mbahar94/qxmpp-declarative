import QtQuick 1.1
import "../Controls"

Item {
    id: delegateRoot

    property bool isCurrent
    property color normal: "#BBBBBB"
    property color highlite: "#FFFF00"

    signal subscribe(string jid)
    signal unsubscribe(string jid)

    width: contactContent.width
    height: contactContent.height

    Timer {
        id: animationTimer

        property bool isOn: false

        running: model.hasNewMessages
        interval: 500
        repeat: true

        onTriggered: {
            console.log("Triggered: " + model.nickname);
            if (!isOn) {
                contactContent.color = delegateRoot.highlite;
            } else {
                contactContent.color = delegateRoot.normal;
            }
            isOn = !isOn;
        }
    }

    Rectangle {
        id: contactContent

        width: 400
        height: 60
        color: delegateRoot.isCurrent ? "#88880000" : delegateRoot.normal

        Behavior on color {
            ColorAnimation { duration: 200 }
        }

        Row {
            spacing: 10
            anchors.fill: parent
            anchors.margins: 10

            Image {
                width: 48
                height: 48
                anchors.verticalCenter: parent.verticalCenter
                source: model.avatar
            }

            Column {
                height: 60
                width: 200
                spacing: 6
                anchors.topMargin: 10

                Text {
                    text: model.nickname
                    font {
                        bold: true
                        family: "Arial"
                        pixelSize: 16
                    }
                }

                Row {
                    spacing: 10

                    StatusIcon {
                        width: 16
                        height: 16
                        state: model.status ? model.status.toLowerCase() : ""
                    }

                    Text {
                        text: model.statusText
                        font {
                            family: "Arial"
                            pixelSize: 12
                        }
                    }
                }
            }
        }
    }
}

