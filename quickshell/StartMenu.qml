import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Io

			
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

	readonly property LinearGradient hovered_button_gradient : AnimatedColorStripeGradient {
		pixel_size : 20
		period: stripe_animation_duration
		stripe1: hovered_stripe1 
		stripe2: hovered_stripe2 
	}

	component ButtonContent: QtObject {
		required property string text
		property list<string> command : []
		property bool close_menu_on_pressed : true
	}
    	Component {
    	    id: buttonContentComponent
    	    ButtonContent {}
    	}
	

	property list<ButtonContent> first_menu_section_buttons
	property list<ButtonContent> second_menu_section_buttons

	property bool completed: false
        Component.onCompleted: {
        	first_menu_section_buttons.push(buttonContentComponent.createObject(root, {text: "Beastiepedia 󰂾", command: [] }));
        	first_menu_section_buttons.push(buttonContentComponent.createObject(root, {text: "Map 󰍍", command: ["CoMaps"] }));
        	first_menu_section_buttons.push(buttonContentComponent.createObject(root, {text: "Items 󰸐", command: ["fuzzel"] }));
        	first_menu_section_buttons.push(buttonContentComponent.createObject(root, {text: "SportNet ", command: [] }));
        	first_menu_section_buttons.push(buttonContentComponent.createObject(root, {text: "Contacts ", command: [], close_menu_on_pressed: false }));

        	second_menu_section_buttons.push(buttonContentComponent.createObject(root, {text:  "Info 🛈", command:["wezterm", "-e", "btop"] }));
        	second_menu_section_buttons.push(buttonContentComponent.createObject(root, {text:  "Monitors Off 󰶐", command:["niri", "msg", "action", "power-off-monitors" ] }));
        	second_menu_section_buttons.push(buttonContentComponent.createObject(root, {text:  "Sleep 󰒲", command:[] }));
		second_menu_section_buttons.push(buttonContentComponent.createObject(root, {text:  "Exit 󰩈", command:["niri", "msg", "action", "quit"] }));

        	completed = true;
        }

	

	IpcHandler {
		target: "start-menu"
		
		function open(): void { root.open(); }
		function close(): void { root.close(); }
		function toggle(): void { root.toggle(); }
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

	function open(): void {
		root.visible = true;
		open_menu_sfx.startDetached();
	}

	function close(): void {
		root.visible = false;
		close_menu_sfx.startDetached();
	}

	function toggle(): void {
		root.visible ? root.close() : root.open();
	}

	Process {
		id: open_menu_sfx
		running: false 
		command: [ "play", "./audio/sfx/ui_menu_in.wav" ]
	}

	Process {
		id: close_menu_sfx
		running: false 
		command: [ "play", "./audio/sfx/ui_menu_out.wav" ]
	}

	MouseArea {
		anchors.fill: parent
		onClicked: () => root.close();
	}
	ColumnLayout {
		x: 150
		y: 40 
		Layout.fillWidth: true
		spacing: 0
		StartMenuSectionBg { id: menu1; section_height: menuItems.height; section_width: menu_option_width; section_angle: menu_option_angle
			animation_source: AnimatedPolkaDotsPattern { 
				texture_size: menu_option_height * density
			}
			ColumnLayout {
				id: menuItems
				layoutDirection: Qt.LeftToRight
				Layout.fillWidth: true

				spacing: 0 
				Repeater {
					model: first_menu_section_buttons
					delegate: StartMenuButton {
						id: menuItem 

						required property int index
						required property var modelData

						Layout.fillHeight: true
						Layout.preferredHeight: root.menu_option_height
						Layout.preferredWidth: root.menu_option_width 
						transform: Translate { x: menu_option_angle_offset * index }

						hovered_gradient: hovered_button_gradient
						
						angle_offset: menu_option_angle_offset
						button_width: root.menu_option_width
						button_height: root.menu_option_height
						
						textColor: white 
						text: modelData.text
						fontFamily: "Hauser"
						fontSize: 42 
						
						shadowOffsetX: -5
						shadowOffsetY:  5

						Process {
							id: button_command
							running: false 
							command: modelData.command
						}

						TapHandler { 
							id: tapHandler
							onTapped: (eventPoint, button) => {
								if(modelData.close_menu_on_pressed) root.visible = false;
								if(modelData.command.length > 0) button_command.startDetached();
							}
						}
					}
				}
			}

		}
		StartMenuSectionBg { id:menu2; section_height: menu2Items.height; section_width: menu_option_width; section_angle: menu_option_angle
			animation_source: AnimatedColoredSquaresPattern { }
			transform: Translate { x: menu1.offset }
			
			ColumnLayout {
				id: menu2Items
				layoutDirection: Qt.LeftToRight
		
				Layout.fillWidth: true
				spacing: 0 
				Repeater {
					model: second_menu_section_buttons
					delegate: StartMenuButton { 
						id: menu2Item 
						required property int index
						required property var modelData

						Layout.fillHeight: true
						Layout.preferredHeight: root.menu_option_height
						Layout.preferredWidth: root.menu_option_width 
						transform: Translate { x: menu_option_angle_offset * index }

						hovered_gradient: hovered_button_gradient
						
						angle_offset: menu_option_angle_offset
						button_width: root.menu_option_width
						button_height: root.menu_option_height
						
						textColor: white 
						text: modelData.text
						fontFamily: "Hauser"
						fontSize: 42 
						
						shadowOffsetX: -5
						shadowOffsetY:  5

						Process {
							id: button_command
							running: false 
							command: modelData.command
						}

						onTapped: () => {
							if(modelData.close_menu_on_pressed) root.close();
							if(modelData.command.length > 0) button_command.startDetached();
						}
					}
				}

			}
		
		}
	}
}


