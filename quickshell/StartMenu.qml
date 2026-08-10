import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.SystemTray

			
PanelWindow {
	property string black: "black"
	property string white: "white"

	property int menu_option_height: 100
	property int menu_option_width: 500
	property real menu_option_angle: 15 * Math.PI / 180 // Radians
	readonly property real menu_option_angle_offset: Math.tan(menu_option_angle) *  menu_option_height// Radians

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
		readonly property real angle: 15 * Math.PI / 180 // Radians

		property int radius: 20 
		property real density: 0.5

		property string color: "#d98abf"
		property string colorbg: "#fc42a0"

		readonly property int texture_size: menu_option_height * density

		height: texture_size; width: texture_size;

		readonly property real dir_len: texture_size / Math.sin(angle) 

		readonly property real xDir: progress * dir_len * Math.cos(angle)
		readonly property real yDir: progress * dir_len * Math.sin(angle)

		PropertyAnimation { running:true; target: colored_dots; properties: "progress"; from: 0; to: 1.0; loops: Animation.Infinite; duration: 2000 }

		Rectangle { x: 0; y: 0; width: colored_dots.texture_size; height: colored_dots.texture_size; color: colored_dots.colorbg }

		Rectangle { x: 0;                     y: 0;                     radius: 180; width: colored_dots.radius; height: colored_dots.radius; color: colored_dots.color			
        		transform: Translate { x: colored_dots.xDir; y: colored_dots.yDir }
		}
		//Rectangle { x: -menu_option_height/2; y: -menu_option_height/2; radius: 180; width: colored_dots.radius; height: colored_dots.radius; color: colored_dots.color
        	//	transform: Translate { x: colored_dots.xDir; y: colored_dots.yDir }
		//}
		//Rectangle { x: 0;                     y: -menu_option_height/2; radius: 180; width: colored_dots.radius; height: colored_dots.radius; color: colored_dots.color
        	//	transform: Translate { x: colored_dots.xDir; y: colored_dots.yDir }
		//}
		Rectangle { x: -menu_option_height/2; y: 0; radius: 180; width: colored_dots.radius; height: colored_dots.radius; color: colored_dots.color
        		transform: Translate { x: colored_dots.xDir; y: colored_dots.yDir }
		}
		Rectangle { x: -menu_option_height/2; y: 0; radius: 180; width: colored_dots.radius; height: colored_dots.radius; color: "red" //colored_dots.color
        		transform: Translate { x: colored_dots.xDir; y: colored_dots.yDir }
		}
		Rectangle { x: -menu_option_height/2 * 2; y: 0; radius: 180; width: colored_dots.radius; height: colored_dots.radius; color: "blue"//colored_dots.color
        		transform: Translate { x: colored_dots.xDir; y: colored_dots.yDir }
		}

		Rectangle { x: -menu_option_height/2 * 3; y: 0; radius: 180; width: colored_dots.radius; height: colored_dots.radius; color: "green"//colored_dots.color
        		transform: Translate { x: colored_dots.xDir; y: colored_dots.yDir }
		}

		//Rectangle { x: -menu_option_height/2 * 0; y: -menu_option_height/2 * 2; radius: 180; width: colored_dots.radius; height: colored_dots.radius; color: "black"//colored_dots.color
        	//	transform: Translate { x: colored_dots.xDir; y: colored_dots.yDir }
		//}
		
        }	    
                                   	    
	
	//MouseArea {
	//	anchors.fill: parent
	//	onClicked: () => trayItemMenu.visible = false;
	//}
	
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
					fillColor: white
					fillItem: ShaderEffectSource {
						width: 100; height: 100
						hideSource: true
						wrapMode: ShaderEffectSource.Repeat
						//wrapMode: ShaderEffectSource.ClampToEdge
						sourceItem: colored_dots
						live: true
        				}
					//fillGradient: hoverHandler.hovered ? hovered_option_gradient : null
					strokeColor: "transparent"
					startX: 0; startY: 0
					PathLine { x: menu_option_angle_offset; y: root.menu_option_height }
					PathLine { x: root.menu_option_width + menu_option_angle_offset; y: root.menu_option_height }
					PathLine { x: root.menu_option_width; y: 0 }
				}
				//HoverHandler { id: hoverHandler }
				TapHandler { 
					id: tapHandler
					onTapped: (eventPoint, button) => root.visible = false;
				}
	
				//Text {
				//	anchors.right: parent.right
				//	anchors.verticalCenter: parent.verticalCenter
				//	text: modelData.text
				//	color: black
				//	font.family: fontFamily
				//	font.pixelSize: fontSize 
				//}
			}
		}
	}
}


