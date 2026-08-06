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
		}
	}
}
