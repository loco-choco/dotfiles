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

	property string fontFamily
	
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
						
						PopupWindow {
							id: trayItemMenu
  							anchor.window: systemTray
  							anchor.rect.x: 0
  							anchor.rect.y: 0

  							visible: false 
							color: "transparent"
							
    							grabFocus: true
    							implicitWidth: systemTray.screen.width
							implicitHeight: systemTray.screen.height

							MouseArea {
    								anchors.fill: parent
    								onClicked: () => trayItemMenu.visible = false;
    							}
							
							ColumnLayout {
								id: menuItems
								layoutDirection: Qt.LeftToRight

								x:  systemTray.screen.width - trayItem.width * (index + 1) - width - tray_angle * trayItemMenuOpener.children.values.filter((entry) => !entry.isSeparator).length
								y: systemTray.screen.height - systemTray.height - height

								Layout.fillWidth: true
								Layout.maximumHeight: 100 
								spacing: 5	
								Repeater {
									model: trayItemMenuOpener.children.values.filter((entry) => !entry.isSeparator)
									delegate: Shape {
										id: trayItem
										required property var modelData 
										required property int index
										Layout.fillHeight: true
										Layout.preferredHeight: tray_height
										Layout.preferredWidth: 120
										containsMode: Shape.FillContains
										preferredRendererType: Shape.CurveRenderer
										transform: Translate { x: tray_angle * index }

										ShapePath {
											id: trayItembg 
											fillColor: white 
											fillGradient: hoverHandler.hovered ? hovered_option_gradient : null
											strokeColor: "transparent"
	    										startX: 0; startY: 0
	    										PathLine { x: tray_angle; y: tray_height }
	    										PathLine { x: 120 + tray_angle; y: tray_height }
	    										PathLine { x: 120; y: 0 }
										}
										HoverHandler { id: hoverHandler }
										TapHandler { 
											id: tapHandler
											onTapped: (eventPoint, button) => {
												modelData.triggered();
												trayItemMenu.visible = false;
											}

										}

										Text {
											anchors.right: parent.right
											anchors.verticalCenter: parent.verticalCenter
											text: modelData.text
											color: black
											font.family: fontFamily
											font.pixelSize: 16
										}
									}
								}
							}

  						}
						//Rectangle {
						//	anchors.right: parent.left
						//	anchors.bottom: parent.verticalCenter
						//	visible: false
						//	width: 100
						//	height: 100
						//}

					}
				}
			}
		}
	}
}


