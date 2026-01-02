import QtQuick

Text {
	// A property the creator of this type is required to set
	// Could just set text, but do this for expansibility

	// Do not need as replaced by the Time singleton
	// required property string time
	// text: time
	
	text: Time.time
}
