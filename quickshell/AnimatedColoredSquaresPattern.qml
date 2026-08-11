import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

Item {
	id: colored_squares 
	property real progress : 0
	readonly property real angle: 45 * Math.PI / 180 // Radians

	property string color: "#3b2876"
	property string colorbg: "#4b3a82"

	readonly property int texture_size: 40 * Math.sqrt(2) 
	readonly property real square_size: texture_size/Math.sqrt(2)

	height: texture_size; width: texture_size;

	readonly property real dir_len: texture_size / Math.sin(angle) 

	readonly property real xDir: progress * dir_len * Math.cos(angle)
	readonly property real yDir: progress * dir_len * Math.sin(angle)

	PropertyAnimation { running:true; target: colored_squares; properties: "progress"; from: 0; to: 1.0; loops: Animation.Infinite; duration: 2000 }

	Rectangle { x: 0; y: 0; width: colored_squares.texture_size; height: colored_squares.texture_size; color: colored_squares.colorbg;  }

	Rectangle { x: colored_squares.texture_size/2;  y: 0;            width: colored_squares.square_size; height: colored_squares.square_size; color: colored_squares.color			
		transform: [ Rotation {angle: 45;}, Translate { x: colored_squares.xDir; y: colored_squares.yDir } ]
	}
	Rectangle { x: -colored_squares.texture_size/2; y: -colored_squares.texture_size; width: colored_squares.square_size; height: colored_squares.square_size; color: colored_squares.color			
		transform: [ Rotation {angle: 45;}, Translate { x: colored_squares.xDir; y: colored_squares.yDir } ]
	}
	Rectangle { x: colored_squares.texture_size/2;  y: -colored_squares.texture_size; width: colored_squares.square_size; height: colored_squares.square_size; color: colored_squares.color			
		transform: [ Rotation {angle: 45;}, Translate { x: colored_squares.xDir; y: colored_squares.yDir } ]
	}
	Rectangle { x: -colored_squares.texture_size/2; y: 0;              width: colored_squares.square_size; height: colored_squares.square_size; color: colored_squares.color			
		transform: [ Rotation {angle: 45;}, Translate { x: colored_squares.xDir; y: colored_squares.yDir } ]
	}
	
}
