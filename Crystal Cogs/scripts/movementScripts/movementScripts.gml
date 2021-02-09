/// @description moveAndCollide()
function moveAndCollide() {
		
	hSpeed += hAcceleration;
	vSpeed += vAcceleration;
	hSpeed *= frictFloor;
		
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