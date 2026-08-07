import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.SystemTray

Item {
	id: root
	property string black: "black"
	property string white: "white"

	property string menu_stripe1: "#2e2e2e"
	property string menu_stripe2: "black"

	property string hovered_stripe1: "#6f6f6f"
	property string hovered_stripe2: "#4f4f4f"

	property string option_stripe1: "#ff904c"
	property string option_stripe2: "#ffb25d"

	property int           stripe_animation_duration: 2000
	property int    hovered_pulse_animation_duration: 2000
	property real hovered_pulse_animation_lightening: 1.5

	property int tray_height: 40 
	property int tray_width:  systemTray.screen.width / 2
	property int tray_angle: 15

	property string fontFamily
	property int fontSize: 16

	property int max_amount_of_options : 10
	property int option_width   : 120
	property int option_spacing : 5
	
	readonly property LinearGradient has_menu_gradient : AnimatedColorStripeGradient {
		period: 2000
		stripe1: menu_stripe1
		stripe2: menu_stripe2 
	}
	
	readonly property LinearGradient hovered_menu_gradient : AnimatedPulsatingStripeGradient {
		stripe_period: 2000
		pulse_period: 2000

		stripe1: hovered_stripe1
		stripe2: hovered_stripe2
		lightening: hovered_pulse_animation_lightening
	}

	readonly property LinearGradient hovered_option_gradient : AnimatedColorStripeGradient {
		period: 2000
		stripe1: "#ff904c" 
		stripe2: "#ffb25d" 
	}
	
	PanelWindow {
		id: systemTray
		anchors.bottom: true
		anchors.right: true
		anchors.left: true
	
		implicitWidth: background.width
		implicitHeight: background.height
	
		color: "transparent"
	
		Shape {
			id: background
			anchors.right: parent.right
			preferredRendererType: Shape.CurveRenderer
			ShapePath {
				id: background_path
				fillColor: black 
				strokeColor: "transparent"
	    			startX: 0; startY: tray_height
	    			PathLine { x: -tray_width + tray_angle; y: tray_height }
	    			PathLine { x: -tray_width; y: 0 }
	    			PathLine { x:   0; y: 0 }
			}
			RowLayout {
				layoutDirection: Qt.RightToLeft
				anchors.right: parent.right
				Layout.maximumWidth: tray_width
				Layout.fillHeight: true
				spacing: 0	
				Repeater {
					model: SystemTray.items.values
					delegate: Shape {
						id: trayItem
						required property var modelData
						required property int index
						Layout.fillHeight: true
						Layout.preferredHeight: tray_height
						Layout.preferredWidth: 60
						containsMode: Shape.FillContains
						preferredRendererType: Shape.CurveRenderer

						ShapePath {
							id: trayItembg 
							fillColor: black
							strokeColor: "transparent"

							fillGradient: !modelData.hasMenu ? null : !hoverHandler.hovered ? has_menu_gradient : hovered_menu_gradient

	    						startX: 0; startY: 0
	    						PathLine { x: tray_angle; y: tray_height }
	    						PathLine { x: 60 + tray_angle; y: tray_height }
	    						PathLine { x: 60; y: 0 }
						}
						Image {
							anchors.fill: parent
							fillMode: Image.PreserveAspectFit
							source: modelData.icon
							
						}
						QsMenuOpener {
							id: trayItemMenuOpener
							menu: modelData.menu
						}
						HoverHandler { id: hoverHandler }
						TapHandler { 
							id: tapHandler
							onTapped: (eventPoint, button) => trayItemMenu.visible = !trayItemMenu.visible

						}

						SystemTrayPopup {
							id: trayItemMenu
							parentWindow: systemTray
							menu: trayItemMenuOpener

							posX: systemTray.screen.width - trayItem.width * (index + 1)
							posY: systemTray.screen.height - systemTray.height
						
							black: black
							white: white
						
							hovered_stripe1: option_stripe1
							hovered_stripe2: option_stripe2
							stripe_animation_duration: stripe_animation_duration
						
							max_amount_of_options: root.max_amount_of_options
						
						
							option_height:  tray_height 
							option_width:   root.option_width
							option_angle:   tray_angle
							option_spacing: root.option_spacing
						
							fontFamily: root.fontFamily
							fontSize :  root.fontSize
						}
					}
				}
			}
		}
	}
}


