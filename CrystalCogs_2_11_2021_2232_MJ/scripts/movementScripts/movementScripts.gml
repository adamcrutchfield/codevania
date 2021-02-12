/// @description moveAndCollide()
function moveAndCollide() {
		
	hSpeed += hAcceleration;
	vSpeed += vAcceleration;
	hSpeed *= frictFloor;
	vSpeed *= frictAir;
		
	if (place_meeting(x + hSpeed, y, objSolid)) {
		while (!place_meeting(x + sign(hSpeed), y, objSolid)) x += sign (hSpeed);
		hSpeed = 0;
	}
	x += hSpeed;
		
	if (place_meeting(x, y + vSpeed, objSolid)) {
		while (!place_meeting(x, y + sign(vSpeed), objSolid)) y += sign (vSpeed);
		vSpeed = 0;
	}
	vSpeed = min(vSpeed, TERMINAL_VELOCITY);
	y += vSpeed;
		
	hAcceleration = 0;
	vAcceleration = grav;
}

function addPointToPath(_x, _y) {
	var newPoint = {
		x : _x,
		y : _y
	}
	array_push(arrPath, newPoint);
	show_debug_message("added point " + string(_x) + " " + string(_y));
	show_debug_message("path: " + string(arrPath));
	//alarm_set(0,30);
}

function calculatePath(_x, _y) {
	addPointToPath(_x, _y + GRID_SIZE/2-1);
	//alarm_set(0,30);
}