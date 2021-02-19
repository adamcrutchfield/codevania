/// initialize macros, enums

#macro GRID_SIZE 32
#macro NUM_COLORS 3
#macro TERMINAL_VELOCITY 30

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

enum soulStates {
	free,
	movingToGolem,
	inGolem,
	exitingGolem
}

enum golemStates {
	empty,
	hasSoul
}

/*
enum machineSides {
	top,
	left,
	right,
	bottom
}
*/

enum golemMaterials {
	crystal,
	wood,
	stone,
	iron,
	gold,
	platinum
}