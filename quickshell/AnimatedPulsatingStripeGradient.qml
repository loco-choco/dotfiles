import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

ColorStripeGradient {
	property string stripe1: "black"
	property string stripe2: "white"

	property real lightening: 1.5

	property int stripe_period : 2000
	property int pulse_period  : 2000

	SequentialAnimation on progress {
		loops: Animation.Infinite
		PropertyAnimation { to: 1.00; duration: stripe_period }
	}
	stripe1_color: hovered_stripe1
	SequentialAnimation on stripe1_color {
		loops: Animation.Infinite
		ColorAnimation { to: stripe1; duration: pulse_period / 2 }
		ColorAnimation { to: Qt.lighter(stripe1, lightening); duration: pulse_period / 2 }
	}
	stripe2_color: hovered_stripe2
	SequentialAnimation on stripe2_color {
		loops: Animation.Infinite
		ColorAnimation { to: stripe2;   duration: pulse_period / 2 }
		ColorAnimation { to: Qt.lighter(stripe2, lightening); duration: pulse_period / 2 }
	}
}
