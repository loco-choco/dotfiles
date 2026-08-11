import QtQuick
import QtQuick.Shapes

LinearGradient {
	property real   progress     : 0
	property string stripe1_color : "black"
	property string stripe2_color : "white"
	property int pixel_size : 10
	x2: pixel_size
	y2: pixel_size
	spread: ShapeGradient.RepeatSpread
	GradientStop { position: (0.01  + progress) % 1.0; color: stripe1_color }
	GradientStop { position: (0.49 + progress) % 1.0;  color: stripe1_color }
	GradientStop { position: (0.51  + progress) % 1.0; color: stripe2_color }
	GradientStop { position: (0.99  + progress) % 1.0; color: stripe2_color }
}
