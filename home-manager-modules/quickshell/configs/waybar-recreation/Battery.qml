pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton {
	id: root
	// property var upower: UPower {}

	readonly property real percentage: {
		UPower.displayDevice.percentage * 100
	}

	readonly property string icon: {

		function getIconFromPercentage() {
			if (percentage >= 80) {
				return " "
			} else if (percentage >= 60) {
				return " "
			} else if (percentage >= 40) {
				return " "
			} else if (percentage >= 20) {
				return " "
			} else {
				return " "
			}
		}

		return UPower.onBattery ? getIconFromPercentage() : "get icon from web you bum"
	}
}
