import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Shapes

import Niri 

import "config.js" as Config

Scope {
	PanelWindow {
		anchors.bottom: true
		anchors.left: true
		anchors.right: true
		implicitHeight: 30 
		color: "transparent"
	}
	
	PanelWindow {
		anchors.top: true
		anchors.left: true
		anchors.right: true
	
		implicitWidth: background.width
		implicitHeight: background.height
	
		color: "transparent"
	
		mask: Region { }
		// Usefull for things to overlay over EVERYTHING
		//WlrLayershell.layer: WlrLayer.Overlay
		
		Niri {
		    id: niri
		    Component.onCompleted: connect()
		
		    onConnected: {
		        console.log("✓ Connected to niri")
		    }
		
		    onDisconnected: {
		        console.log("✗ Disconnected from niri")
		    }
		
		    onErrorOccurred: function(error) {
		        console.log("✗ Connection error:", error)
		    }
		}
		
		SystemClock {
	  		id: clock
	  		precision: SystemClock.Seconds
		}
	
	
		Shape {
			id: background
			anchors.left: parent.left
			//opacity: (niri.focusedWindow != null) ? 0.5 : 1
			ShapePath {
				id: background_path
				fillColor: Config.colors.black 
				strokeColor: "transparent"
	    			startX: 0; startY: Config.clock.height
	    			PathLine { x: Config.clock.width - Config.clock.angle; y: Config.clock.height }
	    			PathLine { x: Config.clock.width; y: 0 }
	    			PathLine { x:   0; y: 0 }
			}
			Item {
				id: clock_display 
				Text {
					id: clock_display_hh
					anchors.left: parent.left
					anchors.verticalCenter: background.verticalCenter
					anchors.leftMargin: Config.clock.spacerMargin
					text: Qt.formatDateTime(clock.date, "hh")				
					color: Config.colors.white
					font.family: Config.clock.fontFamily
					font.pixelSize: Config.clock.fontSize
				}
				Text {
					id: clock_display_hh_mm_spacer
					anchors.left: clock_display_hh.left
					anchors.verticalCenter: background.verticalCenter
					anchors.leftMargin: Config.clock.fontSize 
					text: ":"				
					color: Config.colors.white
					font.family: Config.clock.spacerFontFamily
					font.pixelSize: Config.clock.fontSize
				}
				Text {
					id: clock_display_mm
					anchors.left: clock_display_hh_mm_spacer.left
					anchors.verticalCenter: background.verticalCenter
					anchors.leftMargin: Config.clock.spacerMargin
					text: Qt.formatDateTime(clock.date, "mm")				
					color: Config.colors.white
					font.family: Config.clock.fontFamily
					font.pixelSize: Config.clock.fontSize
				}
				Text {
					id: clock_display_mm_ss_spacer
					anchors.left: clock_display_mm.left
					anchors.verticalCenter: background.verticalCenter
					anchors.leftMargin: Config.clock.fontSize 
					text: ":"				
					color: Config.colors.white
					font.family: Config.clock.spacerFontFamily
					font.pixelSize: 38 
				}
				Text {
					id: clock_display_ss
					anchors.left: clock_display_mm_ss_spacer.left
					anchors.verticalCenter: background.verticalCenter
					anchors.leftMargin: Config.clock.spacerMargin 
					text: Qt.formatDateTime(clock.date, "ss")				
					color: Config.colors.white
					font.family: Config.clock.fontFamily
					font.pixelSize: Config.clock.fontSize
				}
			}
		}
	}
}
