// type becomes singleton
pragma Singleton


import Quickshell
// import Quickshell.Io
import QtQuick


Singleton {
	id: root

	// Changed to use SystemClock
	//
	// adds a property to avoid undefined variables
	// property string time
	//
	// Process {
	// 	// id for lookup in timer
	// 	id: dateProc
	//
	// 	// command will run, every argument its own string
	// 	command: ["date"]
	//
	// 	// run command immediately
	// 	running: true
	//
	// 	// process stdout with StdioCollector
	// 	// retrieves the text process sends to stdout
	// 	stdout: StdioCollector {
	// 		// Listen for streamFinished signal (when process closes stdout or exits)
	// 		// onStreamFinished: clock.text = this.text
	//
	// 		// update property instead of text directly
	// 		onStreamFinished: root.time = this.text
	// 	}
	// }
	//
	// Timer {
	// 	// milis: 1000ms -> 1s
	// 	interval: 1000
	// 	running: true
	//
	// 	// run timer again when ends
	// 	repeat: true
	//
	// 	// when timer triggers sets running to true
	// 	onTriggered: dateProc.running = true
	//
	// }
	
	// expression broken into multiple lines
	readonly property string time: {
		Qt.formatDateTime(clock.date, "yyyy.MM.d | HH:mm")
	}

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}

}
