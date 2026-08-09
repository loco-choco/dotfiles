import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications

Item {
	id: root
	property string black: "black"
	property string white: "white"

	property string popup_stripe1: "#2e2e2e"
	property string popup_stripe2: "black"

	property string hovered_stripe1: "#6f6f6f"
	property string hovered_stripe2: "#4f4f4f"

	property int           stripe_animation_duration: 2000
	property int    hovered_pulse_animation_duration: 2000
	property real hovered_pulse_animation_lightening: 1.5

	property real text_animation_speed: 0.15 

	property int popup_height: 40
	property int popup_width:  500 
	property real popup_angle: 15

	property string fontFamily: "Hauser"
	property int fontSize: 30

	readonly property LinearGradient popup_gradient : AnimatedColorStripeGradient {
		period: 1000
		stripe1: popup_stripe1
		stripe2: popup_stripe2 
	}
	
	readonly property LinearGradient hovered_popup_gradient : AnimatedPulsatingStripeGradient {
		stripe_period: 2000
		pulse_period: 2000

		stripe1: hovered_stripe1
		stripe2: hovered_stripe2
		lightening: hovered_pulse_animation_lightening
	}

	NotificationServer {
		id: server
		actionsSupported: true
		bodySupported: true
		imageSupported: true

		onNotification: n => {
			n.tracked = true;
		}
	}

	PanelWindow {
		id: notificationPopupWindow 
		anchors.top: true

		implicitWidth: popup_width// base.width
		implicitHeight: 40// base.height
		exclusionMode: ExclusionMode.Ignore

		color: "transparent"
		WlrLayershell.layer: WlrLayer.Overlay


		property var currentNotification : server.trackedNotifications.values.length > 0 ? server.trackedNotifications.values[0] : null

		visible: currentNotification != null

		Shape {
			id: background
			anchors.left: parent.left
			preferredRendererType: Shape.CurveRenderer


			property string text_to_display: notificationPopupWindow.currentNotification ? notificationPopupWindow.currentNotification.summary + " --- " + notificationPopupWindow.currentNotification.body : ""

			ShapePath {
				id: background_path
				fillGradient: !hoverHandler.hovered ? popup_gradient : hovered_popup_gradient 
				strokeColor: "transparent"
	    			startX: popup_angle; startY: 0 
	    			PathLine { x: popup_width - popup_angle; y: 0 }
	    			PathLine { x: popup_width; y: popup_height }
	    			PathLine { x:   0; y: popup_height }
			}
			HoverHandler { id: hoverHandler }
			TapHandler { 
				id: tapHandler
				onTapped: (eventPoint, button) => text_animation.complete()

			}
			Shape {
				id: text_clipping_mask 
				anchors.left: parent.left
				layer.enabled: true
				visible: false 
				preferredRendererType: Shape.CurveRenderer
				property int xOffset : notification_content.contentWidth
				property int travelDistance : (notification_content.contentWidth + popup_width)
				NumberAnimation on xOffset {
					id: text_animation
					running: notificationPopupWindow.currentNotification != null
					loops: 1;
					alwaysRunToEnd: true;
					to:notification_content.contentWidth; from: -popup_width
					duration:  text_clipping_mask.travelDistance / root.text_animation_speed
					onFinished: {
						notificationPopupWindow.currentNotification?.dismiss();
						text_animation.stop();
						if(server.trackedNotifications.values.length > 0)
							text_animation.start();
					}
				}
				ShapePath {
					fillColor: white 
					strokeColor: "transparent"
	    				startX: popup_angle + text_clipping_mask.xOffset; startY: 0 
	    				PathLine { x:  popup_width - popup_angle +text_clipping_mask.xOffset; y: 0  }
	    				PathLine { x:  popup_width + text_clipping_mask.xOffset; y: popup_height }
	    				PathLine { x:  0           + text_clipping_mask.xOffset; y: popup_height }
				}
			}
			
			Text {
				id: notification_content
				
				visible: false 
				
        			anchors.fill: text_clipping_mask
				color: white 
				text: background.text_to_display
				font.pixelSize: fontSize
				font.family: fontFamily
			}
			
    			MultiEffect
			{
				id: scrolledText
				transform:  Translate { x: -text_clipping_mask.xOffset }
    				anchors.fill: text_clipping_mask
    				maskEnabled: true
    				source: notification_content
    				maskSource: text_clipping_mask
    			}
		}



	}
}


