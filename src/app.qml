ActivityManager {
	id: mainWindow;
	anchors.fill: parent;

	//@using { src.MainPage }
	LazyActivity { name: "mainPage"; component: "src.MainPage"; }
	//@using { src.List }
	LazyActivity { name: "List"; component: "src.List"; }

	onCompleted: {
		this.push("mainPage");
	}
}