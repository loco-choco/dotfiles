import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

ColorStripeGradient {
	property string stripe1: "black"
	property string stripe2: "white"
	property int    period : 2000

	stripe1_color: stripe1
	stripe2_color: stripe2
	SequentialAnimation on progress {
		loops: Animation.Infinite
		PropertyAnimation { to: 1.00; duration: period }
	}
}
