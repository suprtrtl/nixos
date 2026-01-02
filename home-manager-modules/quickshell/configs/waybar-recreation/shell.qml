import Quickshell
import Niri 0.1

Scope {
	Bar {}

	Niri {
		id: niri
		Component.onCompleted: connect()

		onConnected: console.info("Connected to niri")
		onErrorOccurred: function(error) {
			console.error("Niri error:", error)
		}
	}
}
