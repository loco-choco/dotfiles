//@ pragma UseQApplication
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Shapes

import Niri 

import "config.js" as Config

ShellRoot {
	LazyLoader {
		active: true
		component: Clock {
			black:            Config.colors.black	
			white:            Config.colors.white	
			clock_height:           Config.clock.height
			clock_width:            Config.clock.width
			clock_angle:            Config.clock.angle
			spacerMargin:     Config.clock.spacerMargin
			fontFamily:       Config.clock.fontFamily
			fontSize:         Config.clock.fontSize
			spacerFontFamily: Config.clock.spacerFontFamily
		}
	}
	LazyLoader {
		active: true
		component: SystemTray {
			black:            Config.colors.black	
			white:            Config.colors.white	
			menu_stripe1: "#2e2e2e"
			menu_stripe2: "black"

			hovered_stripe1: "#6f6f6f"
			hovered_stripe2: "#4f4f4f"

			stripe_animation_duration: 2000
			hovered_pulse_animation_duration: 2000
			hovered_pulse_animation_lightening: 1.5

	 		tray_height: 40 
	 		tray_angle: 15
		}
	}
}
