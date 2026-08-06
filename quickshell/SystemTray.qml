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
	property int tray_height: 40 
	property int tray_width:  systemTray.screen.width / 2
	property int tray_angle: 15

	readonly property LinearGradient has_menu_gradient : ColorStripGradient {
		SequentialAnimation on progress {
        		loops: Animation.Infinite
        		PropertyAnimation { to: 1.00; duration: 2000 }
		}
		strip1_color: "#2e2e2e"
		strip2_color: "#black"
	}
	
	readonly property LinearGradient hovered_menu_gradient : ColorStripGradient {
		SequentialAnimation on progress {
        		loops: Animation.Infinite
        		PropertyAnimation { to: 1.00; duration: 2000 }
		}
		strip1_color: "#2e2e2e"
		SequentialAnimation on strip1_color {
        		loops: Animation.Infinite
        		ColorAnimation { to: "#6f6f6f"; duration: 1000 }
        		ColorAnimation { to: Qt.lighter("#6f6f6f"); duration: 1000 }
		}
		strip2_color: "#black"
		SequentialAnimation on strip2_color {
        		loops: Animation.Infinite
        		ColorAnimation { to: "#4f4f4f";   duration: 1000 }
        		ColorAnimation { to: Qt.lighter("#4f4f4f"); duration: 1000 }
		}
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
							//fillGradient: !modelData.hasMenu ? null : !hoverHandler.hovered ? has_menu_gradient : hovered_menu_gradient

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


