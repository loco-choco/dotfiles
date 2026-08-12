import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

Shape {
	id: root 
	containsMode: Shape.FillContains
	preferredRendererType: Shape.CurveRenderer

	property real section_height
	property real section_width
	property real section_angle

	readonly property real offset: Math.tan(section_angle) *  section_height

	property int texture_size : 100 
	property Item animation_source
	
	ShapePath {
		id: bg 
		fillColor: "transparent" 
		fillItem: ShaderEffectSource {
			width: texture_size; height: texture_size
			hideSource: true
			wrapMode: ShaderEffectSource.Repeat
			sourceItem: animation_source 
			live: true
		}
		strokeColor: "transparent"
		startX: 0; startY: 0
		PathLine { x: root.offset; y: root.section_height }
		PathLine { x: root.section_width + root.offset; y: root.section_height }
		PathLine { x: root.section_width; y: 0 }
	}
}

