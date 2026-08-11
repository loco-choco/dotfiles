import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

Item {
	id: colored_dots 
	property real progress : 0
	readonly property real angle: 45 * Math.PI / 180 // Radians

	property int radius: 15 
	property real density: 0.5

	property string color: "#d98abf"
	property string colorbg: "#fc42a0"

	property int texture_size: 10

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
