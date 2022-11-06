Activity {
  id: mainPage;
	anchors.fill: parent;

	Button {
    id: begin;
		x: 15s;
		y: 15s;
		text: 'Начать';
    focus: true;
    border.width: activeFocus ? 1 : 0;
    border.color: "red";
    color: 'black';
    onCompleted: {
      this.setFocus();
    }
    onSelectPressed: {
      mainWindow.push('List');
    }
    onLeftPressed: {
      exit.setFocus();
    }
    onRightPressed: {
      exit.setFocus();
    }
	}

	Button {
    id: exit;
		x: 150s;
		y: 15s;
		text: 'Выход';
    focus: true;
    border.width: activeFocus ? 1 : 0;
    border.color: "red";
    color: 'black';
    onLeftPressed: {
      begin.setFocus();
    }
    onRightPressed: {
      begin.setFocus();
    }
	}
  
}