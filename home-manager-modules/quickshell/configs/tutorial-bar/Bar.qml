import Quickshell
import Quickshell.Io
import QtQuick

// Allows for running the processes outside each panel -> more efficient hopefully
Scope {

	// Variants allow for multiple monitors
	Variants {
		// shell will be created and destroyed based on pluging and unplugging of monitors
		model: Quickshell.screens

		// delegate: Component { -> removed for consciseness
			PanelWindow {
				// screen from screens list will be injected into property
				required property var modelData

				// we can set the windows screen to injected property
				screen: modelData

				anchors {
					top: true
					left: true
					right: true
				}

				implicitHeight: 30

				// Changed for more orginization
				ClockWidget {

				// Subed in for ClockWidget.qml
				//Text {
					// give an id for lookup elsewhere
					// id: clock // removed because not needed

					// center the bar in its parents component (window)
					anchors.centerIn: parent

					// text: root.time  changed to time
					// Not needed because of Time Singleton
					// time: root.time
				}
			}
		// }
	}

}
