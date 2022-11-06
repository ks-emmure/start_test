Activity {
  id: list;
  property string title;
  property array selectedItems;
	anchors.fill: parent;
  onCompleted: {
    this.selectedItems = [];
    this.title = 'Список фильмов';
    back.setFocus();
    listView.currentIndex = 0;
  }

  onDownPressed: {
    listView.setFocus();
  }
  onUpPressed: {
    listView.setFocus();
  }

  Rest {
  id: api;
    baseUrl: ".";

    Method {
      name: "getData";
      path: "/data.json";
    }
  }
  ListModel {
    id: listModel;
    onCompleted: {
      api.getData(
        (data) => {
          this.assign(data.items);
        },
        function(err) { log("Error requesting information", err) }
      )
    }
  }

  Rectangle {
    anchors.fill: parent;
    Button {
      x: 15s;
      y: 15s;
      anchors.leftMargin: 15s;
      anchors.topMargin: 15s;
      text: 'Назад';
      border.width: activeFocus ? 1 : 0;
      border.color: "red";
      color: 'black';
      id: back;
      onSelectPressed: {
        if (list.title === 'Список фильмов') {
          mainWindow.pop();
          return;
        }
        const lastItem = list.selectedItems.pop();
        const previousAlias = list.selectedItems.length ? list.selectedItems[list.selectedItems.length - 1] : lastItem;
        const previousItem = listModel._rows.find((item) => item.alias === previousAlias);
        const previousItemIndex = listModel._rows.findIndex((item) => item.alias === previousAlias);
       
        listView.currentIndex = previousItemIndex;
        listView.setFocus();
        list.title = list.selectedItems.length ? previousItem.title : 'Список фильмов';
      }
    }


    Rectangle {
      width: parent.width;
      height: 50s;
      y: 75s;
      Text {
        text: list.title;
        color: "red";
        font.pixelSize: 28;
        anchors.centerIn: parent;
      }
    }

    ListView {
      width: 1000s;
      height: 310s;
      id: listView;
      anchors.centerIn: parent;
      orientation: ListView.Horizontal;
      model: listModel;
      spacing: 10;
      animationDuration: 1;
      OverflowMixin { value: OverflowMixin.ScrollX; }

      delegate: Rectangle {
        width: 240s;
        height: 310s;
        color: "blue";
        focus: true;
        border.width: activeFocus ? 4 : 0;
        border.color: "red";

        onSelectPressed: {
          list.title = model.title;
          list.selectedItems.push(model.alias);
          listView.currentIndex = 0;
        }
        onDownPressed: {
          listView.activeFocus = false;
          this.activeFocus = false;
          back.setFocus();
        }
        onUpPressed: {
          this.activeFocus = false;
          back.setFocus();
        }
        Rectangle {
          width: parent.width - 20;
          x: 10s;
          height: 30s;
          y: 10s;
          onCompleted: {
            this.style("pointer-events", "none");
          }

          Text {
            id: title;
            width: parent.width;
            anchors.top: parent.top;
            text: model.title;
            color: "white";
					  clip: true;
            font.pixelSize: 24;

            onCompleted: {
              this.style("text-overflow", "ellipsis");
            }
          }
        }

        Rectangle {
          width: parent.width - 20;
          x: 10s;
          height: 150s;
          y: 40s;

          onCompleted: {
            this.style("pointer-events", "none");
          }

          Text {
            id: title;
            width: parent.width;
            height: (20 * 5) - 3;
            anchors.top: parent.top;
            text: model.description;
            color: "white";
					  clip: true;
            font.pixelSize: 16;
            wrapMode: Text.WordWrap;

            onCompleted: {
						  var lines = 5
              this.style("display", "block");
              this.style("display", "-webkit-box");
              this.style("text-overflow", "ellipsis");
              this.style('line-clamp', lines);
              this.style('-webkit-line-clamp', lines);
              this.style('box-orient', "vertical");
              this.style('-webkit-box-orient', "vertical");
            }
          }
        }

        Image {
          x: 10s;
          width: 100% - 20s;
          anchors.bottom: parent.bottom;
          height: 150s;
          source: "./images/"+model.image;
          fillMode: Image.PreserveAspectFit;

          onCompleted: {
            this.style("pointer-events", "none");
          }
        }

        Image {
          anchors.right: parent.right;
          anchors.rightMargin: 25s;
          width: 25;
          height: 25;
          source: model.source ? model.source : '';
        }
      }
    }
  }
}