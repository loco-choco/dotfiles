import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.SystemTray

			
PopupWindow {
	required property QsWindow parentWindow
	required property QsMenuOpener menu

	readonly property var menu_options: menu.children.values.filter((entry) => !entry.isSeparator)

	property int posX : 0
	property int posY : 0

	property string black: "black"
	property string white: "white"

	property string hovered_stripe1: "#ff904c"
	property string hovered_stripe2: "#ffb25d"
	property int    stripe_animation_duration: 2000

	property int max_amount_of_options: 10


	property int option_height: 40 
	property int option_width: 120 
	property int option_angle: 15
	property int option_spacing: 5

	property string fontFamily
	property int fontSize : 16 

	readonly property LinearGradient hovered_option_gradient : AnimatedColorStripeGradient {
		period: stripe_animation_duration
		stripe1: hovered_stripe1 
		stripe2: hovered_stripe2 
	}

	id: root
	anchor.window: parentWindow
	anchor.rect.x: 0
	anchor.rect.y: 0
	
	visible: false 
	color: "transparent"
	
	implicitWidth: parentWindow.screen.width
	implicitHeight: parentWindow.screen.height
	
	MouseArea {
		anchors.fill: parent
		onClicked: () => trayItemMenu.visible = false;
	}
	
	ColumnLayout {
		id: menuItems
		layoutDirection: Qt.LeftToRight
	
		x: posX - width - option_angle * menu_options.length
		y: posY - height
	
		Layout.fillWidth: true
		Layout.maximumHeight:  (option_height + option_spacing) * max_amount_of_options
		spacing: option_spacing
		Repeater {
			model: menu_options
			delegate: Shape {
				id: trayItem
				required property var modelData 
				required property int index
				Layout.fillHeight: true
				Layout.preferredHeight: option_height
				Layout.preferredWidth: option_width
				containsMode: Shape.FillContains
				preferredRendererType: Shape.CurveRenderer
				transform: Translate { x: option_angle * index }
	
				ShapePath {
					id: trayItembg 
					fillColor: white 
					fillGradient: hoverHandler.hovered ? hovered_option_gradient : null
					strokeColor: "transparent"
					startX: 0; startY: 0
					PathLine { x: option_angle; y: option_height }
					PathLine { x: option_width + option_angle; y: option_height }
					PathLine { x: option_width; y: 0 }
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
					font.pixelSize: fontSize 
				}
			}
		}
	}
}


