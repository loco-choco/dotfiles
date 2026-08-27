import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Shapes

Item {
	id: root
	property string black: "black"
	property string white: "white"
	property int clock_height: 40 
	property int clock_width: 40 
	property int clock_angle: 40 
	property int spacerMargin: 30
	property string fontFamily: "" 
	property int fontSize: 30
	property string spacerFontFamily: ""

	property string clock_stripe1: "#2e2e2e"
	property string clock_stripe2: "black"

	property int           stripe_animation_duration: 2000
	property int    hovered_pulse_animation_duration: 2000
	property real hovered_pulse_animation_lightening: 2
	
	readonly property LinearGradient clock_gradient : AnimatedColorStripeGradient {
		period: 2000
		stripe1: clock_stripe1
		stripe2: clock_stripe2 
	}
	
	readonly property LinearGradient hovered_clock_gradient : AnimatedPulsatingStripeGradient {
		stripe_period: 2000
		pulse_period: 2000

		stripe1: clock_stripe1
		stripe2: clock_stripe2
		lightening: hovered_pulse_animation_lightening
	}

	signal pressed()

	PanelWindow {
		anchors.top: true
		anchors.left: true
		anchors.right: true
	
		implicitWidth: background.width
		implicitHeight: background.height
	
		color: "transparent"
		
		SystemClock {
	  		id: clock
	  		precision: SystemClock.Seconds
		}
	
		Shape {
			id: background
			anchors.left: parent.left
			preferredRendererType: Shape.CurveRenderer

			ShapePath {
				id: background_path
				fillColor: black 
				fillGradient: hoverHandler.hovered ? hovered_clock_gradient : clock_gradient
				strokeColor: "transparent"
	    			startX: 0; startY: clock_height
	    			PathLine { x: clock_width - clock_angle; y: clock_height }
	    			PathLine { x: clock_width; y: 0 }
	    			PathLine { x:   0; y: 0 }
			}

			HoverHandler { 
				id: hoverHandler
			}

			TapHandler { 
				id: tapHandler
				onTapped: (eventPoint, button) => root.pressed()
			}

			Item {
				id: clock_display 
				anchors.verticalCenter: background.verticalCenter
				Text {
					id: clock_display_hh
					anchors.left: parent.left
					anchors.verticalCenter: parent.verticalCenter
					anchors.leftMargin: spacerMargin
					text: Qt.formatDateTime(clock.date, "hh")				
					color: white
					font.family: fontFamily
					font.pixelSize: fontSize
				}
				Text {
					id: clock_display_hh_mm_spacer
					anchors.left: clock_display_hh.left
					anchors.verticalCenter: parent.verticalCenter
					anchors.leftMargin: fontSize 
					text: ":"				
					color: white
					font.family: spacerFontFamily
					font.pixelSize: fontSize
				}
				Text {
					id: clock_display_mm
					anchors.left: clock_display_hh_mm_spacer.left
					anchors.verticalCenter: parent.verticalCenter
					anchors.leftMargin: spacerMargin
					text: Qt.formatDateTime(clock.date, "mm")				
					color: white
					font.family: fontFamily
					font.pixelSize: fontSize
				}
				Text {
					id: clock_display_mm_ss_spacer
					anchors.left: clock_display_mm.left
					anchors.verticalCenter: parent.verticalCenter
					anchors.leftMargin: fontSize 
					text: ":"				
					color: white
					font.family: spacerFontFamily
					font.pixelSize: fontSize 
				}
				Text {
					id: clock_display_ss
					anchors.left: clock_display_mm_ss_spacer.left
					anchors.verticalCenter: parent.verticalCenter
					anchors.leftMargin: spacerMargin 
					text: Qt.formatDateTime(clock.date, "ss")				
					color: white
					font.family: fontFamily
					font.pixelSize: fontSize
				}
			}
		}
	}
}
