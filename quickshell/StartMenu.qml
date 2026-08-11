import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.SystemTray

			
PanelWindow {
	property string black: "black"
	property string white: "white"

	property int menu_option_height: 80
	property int menu_option_width: 500
	property real menu_option_angle: 15 * Math.PI / 180 // Radians
	readonly property real menu_option_angle_offset: Math.tan(menu_option_angle) *  menu_option_height// Radians

	property string hovered_stripe1: "#ff904c"
	property string hovered_stripe2: "#ffb25d"
	property int    stripe_animation_duration: 1000

	property int max_amount_of_options: 10

	property string fontFamily
	property int fontSize : 16 

	readonly property LinearGradient hovered_option_gradient : AnimatedColorStripeGradient {
		pixel_size : 20
		period: stripe_animation_duration
		stripe1: hovered_stripe1 
		stripe2: hovered_stripe2 
	}

	id: root
	
	visible: true 
	color: "transparent"
	
	implicitWidth: screen.width
	implicitHeight: screen.height

	anchors.top: true
	anchors.right: true
	anchors.left: true
	
	exclusionMode: ExclusionMode.Ignore

	property var colored_dots: Item {
		id: colored_dots 
		property real progress : 0
		readonly property real angle: 45 * Math.PI / 180 // Radians

		property int radius: 15 
		property real density: 0.5

		property string color: "#d98abf"
		property string colorbg: "#fc42a0"

		readonly property int texture_size: menu_option_height * density

		height: texture_size; width: texture_size;

		readonly property real dir_len: texture_size / Math.sin(angle) 

		readonly property real xDir: progress * dir_len * Math.cos(angle)
		readonly property real yDir: progress * dir_len * Math.sin(angle)

		PropertyAnimation { running:true; target: colored_dots; properties: "progress"; from: 0; to: 1.0; loops: Animation.Infinite; duration: 2000 }

		Rectangle { x: 0; y: 0; width: colored_dots.texture_size; height: colored_dots.texture_size; color: colored_dots.colorbg;  }

		Rectangle { x: 0;                          y: 0;            radius: 180; width: colored_dots.radius; height: colored_dots.radius; color: colored_dots.color			
        		transform: Translate { x: colored_dots.xDir; y: colored_dots.yDir }
		}
		Rectangle { x: -colored_dots.texture_size; y: -colored_dots.texture_size; radius: 180; width: colored_dots.radius; height: colored_dots.radius; color: colored_dots.color 
        		transform: Translate { x: colored_dots.xDir; y: colored_dots.yDir }
		}
		Rectangle { x: 0;                          y: -colored_dots.texture_size; radius: 180; width: colored_dots.radius; height: colored_dots.radius; color: colored_dots.color
        		transform: Translate { x: colored_dots.xDir; y: colored_dots.yDir }
		}
		Rectangle { x: -colored_dots.texture_size; y: 0;             radius: 180; width: colored_dots.radius; height: colored_dots.radius; color: colored_dots.color 
        		transform: Translate { x: colored_dots.xDir; y: colored_dots.yDir }
		}		
	}        

	property var colored_squares: Item {
		id: colored_squares 
		property real progress : 0
		readonly property real angle: 45 * Math.PI / 180 // Radians

		property string color: "#3b2876"
		property string colorbg: "#4b3a82"

		readonly property int texture_size: 40 * Math.sqrt(2) 
		readonly property real square_size: texture_size/Math.sqrt(2)

		height: texture_size; width: texture_size;

		readonly property real dir_len: texture_size / Math.sin(angle) 

		readonly property real xDir: progress * dir_len * Math.cos(angle)
		readonly property real yDir: progress * dir_len * Math.sin(angle)

		PropertyAnimation { running:true; target: colored_squares; properties: "progress"; from: 0; to: 1.0; loops: Animation.Infinite; duration: 2000 }

		Rectangle { x: 0; y: 0; width: colored_squares.texture_size; height: colored_squares.texture_size; color: colored_squares.colorbg;  }

		Rectangle { x: colored_squares.texture_size/2;  y: 0;            width: colored_squares.square_size; height: colored_squares.square_size; color: colored_squares.color			
        		transform: [ Rotation {angle: 45;}, Translate { x: colored_squares.xDir; y: colored_squares.yDir } ]
		}
		Rectangle { x: -colored_squares.texture_size/2; y: -colored_squares.texture_size; width: colored_squares.square_size; height: colored_squares.square_size; color: colored_squares.color			
        		transform: [ Rotation {angle: 45;}, Translate { x: colored_squares.xDir; y: colored_squares.yDir } ]
		}
		Rectangle { x: colored_squares.texture_size/2;  y: -colored_squares.texture_size; width: colored_squares.square_size; height: colored_squares.square_size; color: colored_squares.color			
        		transform: [ Rotation {angle: 45;}, Translate { x: colored_squares.xDir; y: colored_squares.yDir } ]
		}
		Rectangle { x: -colored_squares.texture_size/2; y: 0;              width: colored_squares.square_size; height: colored_squares.square_size; color: colored_squares.color			
        		transform: [ Rotation {angle: 45;}, Translate { x: colored_squares.xDir; y: colored_squares.yDir } ]
		}
		
        }                                 	    
	
	//MouseArea {
	//	anchors.fill: parent
	//	onClicked: () => trayItemMenu.visible = false;
	//}
	ColumnLayout {
		Layout.fillWidth: true
		spacing: 0 
		Shape {
			id: menubg 
			Layout.fillHeight: true
			Layout.preferredHeight: root.menu_option_height * 5
			Layout.preferredWidth: root.menu_option_width 
			containsMode: Shape.FillContains
			preferredRendererType: Shape.CurveRenderer
		
			ShapePath {
				id: menuItembg 
				fillColor: white
				fillItem: ShaderEffectSource {
					width: 100; height: 100
					hideSource: true
					wrapMode: ShaderEffectSource.Repeat
					sourceItem: colored_dots
					live: true
        			}
				//fillGradient: hoverHandler.hovered ? hovered_option_gradient : null
				strokeColor: "transparent"
				startX: 0; startY: 0
				PathLine { x: menu_option_angle_offset*5; y: root.menu_option_height*5 }
				PathLine { x: root.menu_option_width + menu_option_angle_offset*5; y: root.menu_option_height*5 }
				PathLine { x: root.menu_option_width; y: 0 }
			}
			ColumnLayout {
				id: menuItems
				layoutDirection: Qt.LeftToRight
		
				//x: posX - width - option_angle * menu_options.length
				//y: posY - height
		
				Layout.fillWidth: true
				spacing: 0 
				Repeater {
					model: 5
					delegate: Shape {
						id: menuItem 
						required property int index
						Layout.fillHeight: true
						Layout.preferredHeight: root.menu_option_height
						Layout.preferredWidth: root.menu_option_width 
						containsMode: Shape.FillContains
						preferredRendererType: Shape.CurveRenderer
						transform: Translate { x: menu_option_angle_offset * index }
		
						ShapePath {
							id: menuItembg 
							fillColor: "transparent" 
							fillGradient: hoverHandler.hovered ? hovered_option_gradient : null
							strokeColor: "transparent" 
							startX: 0; startY: 0
							PathLine { x: menu_option_angle_offset; y: root.menu_option_height }
							PathLine { x: root.menu_option_width + menu_option_angle_offset; y: root.menu_option_height }
							PathLine { x: root.menu_option_width; y: 0 }
						}
						HoverHandler { id: hoverHandler }
						TapHandler { 
							id: tapHandler
							onTapped: (eventPoint, button) => root.visible = false;
						}

						Text {
							anchors.right: parent.right
							anchors.verticalCenter: parent.verticalCenter
							text: "Beastiepedia 󱓷"
							font.letterSpacing: 1
							color: "#80000000" 
							font.family: "Hauser" 
							font.bold: true
							font.pixelSize:  42
							transform: Translate {x: -5; y: 5}
						}
		
						Text {
							anchors.right: parent.right
							anchors.verticalCenter: parent.verticalCenter
							text: "Beastiepedia 󱓷"
							font.letterSpacing: 1
							color: white 
							font.family: "Hauser" 
							font.bold: true
							font.pixelSize:  42
						}
					}
				}
			}

		}
		Shape {
			id: menu2bg 
			Layout.fillHeight: true
			Layout.preferredHeight: root.menu_option_height * 5
			Layout.preferredWidth: root.menu_option_width 
			containsMode: Shape.FillContains
			preferredRendererType: Shape.CurveRenderer
			transform: Translate { x: menu_option_angle_offset * 5 }
		
			ShapePath {
				id: menu2Itembg 
				fillColor: white
				fillItem: ShaderEffectSource {
					width: 100; height: 100
					hideSource: true
					wrapMode: ShaderEffectSource.Repeat
					sourceItem: colored_squares
					live: true
        			}
				//fillGradient: hoverHandler.hovered ? hovered_option_gradient : null
				strokeColor: "transparent"
				startX: 0; startY: 0
				PathLine { x: menu_option_angle_offset*3; y: root.menu_option_height*3 }
				PathLine { x: root.menu_option_width + menu_option_angle_offset*3; y: root.menu_option_height*3 }
				PathLine { x: root.menu_option_width; y: 0 }
			}
			ColumnLayout {
				id: menu2Items
				layoutDirection: Qt.LeftToRight
		
				//x: posX - width - option_angle * menu_options.length
				//y: posY - height
		
				Layout.fillWidth: true
				spacing: 0 
				Repeater {
					model: 3
					delegate: Item { 
						id: menu2Item 
						required property int index
						Layout.fillHeight: true
						Layout.preferredHeight: root.menu_option_height
						Layout.preferredWidth: root.menu_option_width 
						transform: Translate { x: menu_option_angle_offset * index }
		
						Shape {
							id: menu2Itembg 
							containsMode: Shape.FillContains
							preferredRendererType: Shape.CurveRenderer

							ShapePath {
								fillColor: "transparent" 
								fillGradient: hoverHandler.hovered ? hovered_option_gradient : null
								strokeColor: "transparent"
								startX: 0; startY: 0
								PathLine { x: menu_option_angle_offset; y: root.menu_option_height }
								PathLine { x: root.menu_option_width + menu_option_angle_offset; y: root.menu_option_height }
								PathLine { x: root.menu_option_width; y: 0 }
							}
						}
						HoverHandler { id: hoverHandler }
						TapHandler { 
							id: tapHandler
							onTapped: (eventPoint, button) => root.visible = false;
						}

						Text {
							anchors.right: parent.right
							anchors.verticalCenter: parent.verticalCenter
							text: "Info 🛈"
							font.letterSpacing: 1
							color: "#80000000" 
							font.family: "Hauser" 
							font.bold: true
							font.pixelSize:  42
							transform: Translate {x: -5; y: 5}
						}
		
						Text {
							anchors.right: parent.right
							anchors.verticalCenter: parent.verticalCenter
							text: "Info 🛈"
							font.letterSpacing: 1
							color: white 
							font.family: "Hauser" 
							font.bold: true
							font.pixelSize:  42
						}
					}
				}
			}

		}

		
	}
}


