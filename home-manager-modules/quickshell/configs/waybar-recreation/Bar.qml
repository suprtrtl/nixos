import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
	Variants {
		model: Quickshell.screens
		PanelWindow {
			required property var modelData

			screen: modelData

			anchors {
				top: true
				left: true
				right: true
			}

			margins {
				top: 8
				left: 8
				right: 8
			}

			implicitHeight: 30

			color: "transparent"

			Rectangle {
				anchors.fill: parent

				radius: 5 
				color: "#282c34"
			}


			RowLayout {
				id: content
				anchors.fill: parent
				spacing: 5


				Text {
					text: "  "
					color: "#dcdfe4"
					font {
						pixelSize: 12
						family: "JetBrainsMono Nerd Font"
					}
				}

				Repeater {
					model: 9
					Text {
						text: index + 1
						color: "#dcdfe4"
						font {
							pixelSize: 12
							family: "JetBrainsMono Nerd Font"
						}

					}
				}

				Seperator {}

				Text {
					text: "nvim"
					color: "#dcdfe4"
					font {
						pixelSize: 12
						family: "JetBrainsMono Nerd Font"
					}
				}

				Item { Layout.fillWidth: true }

				Text {
					text: "  " + Brightness.brightness + "%"
					color: "#dcdfe4"
					font {
						pixelSize: 12
						family: "JetBrainsMono Nerd Font"
					}
				}

				Seperator {}

				Text {
					text: Battery.icon +  " " + Battery.percentage + "%"
					color: "#dcdfe4"
					font {
						pixelSize: 12
						family: "JetBrainsMono Nerd Font"
					}
				}

				Seperator {}

				Text {
					text: Time.time
					color: "#dcdfe4"
					font {
						pixelSize: 12
						family: "JetBrainsMono Nerd Font"
					}
				}

				Text {
					text: " "
					color: "#dcdfe4"
					font {
						pixelSize: 12
						family: "JetBrainsMono Nerd Font"
					}
				}
			}
			
		}
	}
}


