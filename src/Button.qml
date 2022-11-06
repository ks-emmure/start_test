Rectangle {
	id: buttonProto;
	property string text: "";
	color: activeFocus ? '#f00' : '#00f';
	height: 50;
	width: 100;
	radius: 4;
	focus: true;

	Text {
		id: buttonInnerText;
		anchors.centerIn: parent;
		color: '#f00';
		text: buttonProto.text;
	}
	Behavior on color { ColorAnimation { duration: 0.5; } }
}