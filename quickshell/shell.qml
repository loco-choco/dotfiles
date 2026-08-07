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
			clock_height:     Config.clock.height
			clock_width:      Config.clock.width
			clock_angle:      Config.clock.angle
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
			
			option_stripe1: "#ff904c"
			option_stripe2: "#ffb25d"

			stripe_animation_duration: Config.systray.animation.stripe_period 
			hovered_pulse_animation_duration: Config.systray.animation.pulse_period 
			hovered_pulse_animation_lightening: Config.systray.animation.pulse_factor

	 		tray_height: Config.systray.height 
	 		tray_angle: Config.systray.angle
			
			fontFamily: Config.systray.fontFamily
			fontSize: Config.systray.fontSize

			max_amount_of_options : Config.systray.options.max
			option_width   : Config.systray.options.width
			option_spacing : Config.systray.options.spacing
		}
	}
}
