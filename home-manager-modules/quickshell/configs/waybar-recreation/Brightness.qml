pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {

	id: root
	property string brightness

	Process {
		// id for lookup in timer
		id: brightnessProc

		// command will run, every argument its own string
		command: ["sh", "-c", "brightnessct i | grep Current | awk '{print $3}'"]

		// run command immediately
		running: true

		// process stdout with StdioCollector
		// retrieves the text process sends to stdout
		stdout: StdioCollector {
			// Listen for streamFinished signal (when process closes stdout or exits)
			// onStreamFinished: clock.text = this.text

			// update property instead of text directly
			onStreamFinished: root.brightness = this.text
		}
	}

	Timer {
		// milis: 1000ms -> 1s
		interval: 1000
		running: true

		// run timer again when ends
		repeat: true

		// when timer triggers sets running to true
		onTriggered: brightnessProc.running = true

	}
}
