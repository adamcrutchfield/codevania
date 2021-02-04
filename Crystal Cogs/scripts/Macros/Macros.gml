/// initialize macros, enums, and global vars

#macro GRID_SIZE 32
#macro NUM_COLORS 3

enum lightColors {
	red,
	green,
	blue
}

enum laserDirections {
	right,
	rightUp,
	up,
	leftUp,
	left,
	leftDown,
	down,
	rightDown
}

enum playerStates {
	idle
}