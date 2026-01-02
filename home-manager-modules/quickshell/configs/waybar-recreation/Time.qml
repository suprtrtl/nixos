pragma Singleton

import Quickshell
import QtQuick


Singleton {
	id: root

	readonly property string time: {
		Qt.formatDateTime(clock.date, "yyyy.MM.d - HH:mm")
	}

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}

}
