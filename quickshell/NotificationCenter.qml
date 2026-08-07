import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications

Item {
	id: root
	property string black: "black"
	property string white: "white"

	property string menu_stripe1: "#2e2e2e"
	property string menu_stripe2: "black"

	property string hovered_stripe1: "#6f6f6f"
	property string hovered_stripe2: "#4f4f4f"

	property string option_low_priority: Qt.darker(white, 2)
	property string option_normal_priority: white 
	property string option_high_priority: "#ff904c"

	property int           stripe_animation_duration: 2000
	property int    hovered_pulse_animation_duration: 2000
	property real hovered_pulse_animation_lightening: 1.5

	property int popup_height: 200
	property int popup_width:  300 
	property real popup_angle: 15

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

	NotificationServer {
		id: server
		actionsSupported: true
		bodySupported: true
		imageSupported: true

		onNotification: n => {
			console.log("got:", n.summary, "---", n.body);
			n.tracked = true;
		}
	}

	PanelWindow {
		anchors.bottom: true
		anchors.right: true

		implicitWidth: base.width
		implicitHeight: base.height + notif_enumeration.height

		color: "transparent"
		Shape {
			id: base 
			anchors.right: parent.right
			preferredRendererType: Shape.CurveRenderer
			ShapePath {
				id: background_path
				fillColor: white 
				strokeColor: "transparent"
	    			startX: 0; startY: 0 
	    			PathLine { x: Math.tan(Math.PI * popup_angle / 180) * popup_height; y: popup_height }
	    			PathLine { x: popup_width; y: popup_height }
	    			PathLine { x: popup_width; y: 0 }
			}

			property int user_selected : 0
			property int selected : Math.min(user_selected, server.trackedNotifications.values.length - 1)	
			property var selected_notification : server.trackedNotifications.values[selected]
			Shape {
				id: content
				anchors.top: base.top
				anchors.right: base.right
				
				preferredRendererType: Shape.CurveRenderer
				ShapePath {
					id: content_bg
					fillColor: "red" 
					strokeColor: "transparent"
	    				startX: 5; startY: 10
	    				PathLine { x: Math.tan(Math.PI * popup_angle / 180) * (popup_height - 60) + 5 ; y: (popup_height - 60) + 10 }
	    				PathLine { x: popup_width - 10; y: (popup_height - 60) + 10 }
	    				PathLine { x: popup_width - 10; y: 10 }
				}
				Rectangle {
					anchors.top: parent.top
					anchors.right: parent.right
					anchors.verticalCenter: parent.verticalCenter

					color: "blue"
					width: 	parent.width
					height: parent.height 
					Text {
						anchors.verticalCenter: parent.verticalCenter
						id: body_text 
						font.family: "Go Banana"
						font.pixelSize: 26
						text: base.selected_notification.body//"Get the Soundtrack!"
					}
				}
			}
			Rectangle {
				anchors.bottom: base.bottom
				anchors.right: base.right

				color: "transparent"

				width: popup_width - Math.tan(Math.PI * popup_angle / 180) * (popup_height - 60) + 5 - 40
				height: 60 - 10
				Text {
					anchors.verticalCenter: parent.verticalCenter
					id: title
					font.family: "Go Banana"
					font.pixelSize: 26
					text: base.selected_notification.summary//"Get the Soundtrack!"
				}
			}
			Rectangle {
				id: notif_enumeration
				anchors.top: base.bottom
				anchors.right: base.right
				width: popup_width - Math.tan(Math.PI * popup_angle / 180) * popup_height
				height: 40
				
				color: "transparent"

				RowLayout {
					layoutDirection: Qt.RightToLeft
					anchors.right: parent.right
					anchors.verticalCenter: parent.verticalCenter
					spacing: 15
					Repeater {
						model: server.trackedNotifications
						delegate: Rectangle {
							id: option
							required property var modelData
							required property int index
							
							width: 20
							height: 20
							color: black
							border {
								color: modelData.urgency === NotificationUrgency.Critical ? option_high_priority : modelData.urgency === NotificationUrgency.Normal ? option_normal_priority : option_low_priority
								width: 2
							}
							radius: 180
							Rectangle {
								anchors.verticalCenter: parent.verticalCenter
								anchors.horizontalCenter: parent.horizontalCenter
								width: 12
								height: 12
								color: base.selected != index && !hoverHandler.hovered ? black : Qt.darker(modelData.urgency === NotificationUrgency.Critical ? option_high_priority : modelData.urgency === NotificationUrgency.Normal ? option_normal_priority : option_low_priority, hoverHandler.hovered && base.selected != index ? 2.0 : 1.0)
								radius: 180
							}
							HoverHandler { id: hoverHandler }
							TapHandler { 
								id: tapHandler
								onTapped: (eventPoint, button) => base.user_selected = index

							}

							
						}
					}
				}
			}
		}



	}
	
	//FloatingWindow {
	//	id: notificationManager 
	//	implicitWidth: background.width
	//	implicitHeight: background.height

	//	color: "transparent"

	//	Rectangle {
	//		id: background
	//		anchors.bottom: parent.bottom
	//		anchors.left: parent.left
	//		width: 100
	//		height: 100
	//	}

	//}
}


