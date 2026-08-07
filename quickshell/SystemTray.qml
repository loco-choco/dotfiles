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

	property int           stripe_animation_duration: 2000
	property int    hovered_pulse_animation_duration: 2000
	property real hovered_pulse_animation_lightening: 1.5

	property int tray_height: 40 
	property int tray_width:  systemTray.screen.width / 2
	property int tray_angle: 15
	
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
						Layout.fillHeight: true
						Layout.preferredHeight: tray_height
						Layout.preferredWidth: 60
						containsMode: Shape.FillContains

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
						QsMenuAnchor {
							id: trayItemMenu
							menu: modelData.menu
							anchor {
								item: parent 
								edges: Edges.Top | Edges.Left
								gravity: Edges.Top | Edges.Left
							}
						}
						HoverHandler { id: hoverHandler }
						TapHandler { 
							id: tapHandler
							onTapped: (eventPoint, button) => trayItemMenu.open()

						}

					}
				}
			}
		}
	}
}


