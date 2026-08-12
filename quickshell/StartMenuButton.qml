import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import QtQuick.Effects

Shape {
	id: root 
	containsMode: Shape.FillContains
	preferredRendererType: Shape.CurveRenderer

	property var hovered_gradient

	property int angle_offset
	property int button_width 
	property int button_height

	property var textColor : "white"
	property string text : "Info 🛈"
	property string fontFamily : "Hauser"
	property int fontSize : 42 

	property real shadowOpacity : 0.5 
	property int shadowOffsetX : -5
	property int shadowOffsetY :  5

	ShapePath {
		fillColor: "transparent" 
		fillGradient: hoverHandler.hovered ? hovered_gradient : null
		strokeColor: "transparent"
		startX: 0; startY: 0
		PathLine { x: root.angle_offset; y: root.button_height }
		PathLine { x: root.button_width + root.angle_offset; y: root.button_height }
		PathLine { x: root.button_width; y: 0 }
	}

	HoverHandler { id: hoverHandler }

    	MultiEffect {
		source: textContent; anchors.fill: textContent;
		shadowEnabled: true; shadowBlur: 0; shadowOpacity: root.shadowOpacity; shadowHorizontalOffset: root.shadowOffsetX; shadowVerticalOffset: shadowOffsetY;
    	}
	
	Text {
		id: textContent
		anchors.right: parent.right
		anchors.verticalCenter: parent.verticalCenter
		text: root.text
		font.letterSpacing: 1
		color: root.textColor
		font.family: root.fontFamily
		font.bold: true
		font.pixelSize: root.fontSize
	}
}
