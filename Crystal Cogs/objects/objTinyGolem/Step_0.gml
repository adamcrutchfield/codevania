/// @description Insert description here
// You can write your code in this editor

var jump = false;
var lClick = mouse_check_button_pressed(mb_left);
var rCLick = mouse_check_button_pressed(mb_right);

if rCLick {
	addPointToPath(global.gridTargetX, global.gridTargetY + GRID_SIZE/2-1);
}
if lClick arrPath = array_create(0, 0);

var hasPath = array_length(arrPath) > 0;

var xDisplacement = 0;
var yDisplacement = 0;

var inTargetX = true;
var inTargetY = true;

if (hasPath) {
	xDisplacement = arrPath[0].x - x;
	yDisplacement = arrPath[0].y - y;
	
	inTargetX = bbox_left > arrPath[0].x - GRID_SIZE/2 and bbox_right < arrPath[0].x + GRID_SIZE/2 - 1;
	inTargetY = bbox_top > arrPath[0].y - GRID_SIZE/2 and bbox_bottom < arrPath[0].y + GRID_SIZE/2 - 1;
}
var inTargetGrid = inTargetX and inTargetY;

///movement
var walkDirection = 0;
if (array_length(arrPath) > 0) walkDirection = sign(xDisplacement);
hAcceleration += walkDirection * moveSpeed;

if (hasPath) jump = ((abs(xDisplacement) <= GRID_SIZE * 3) and (yDisplacement - jumpTarget <= 0) and yDisplacement < 0);
var jumpStrength = sqrt(2 * grav * jumpTarget) + grav / 2;

if (place_meeting(x, y + 1, objSolid)) jumpBuffer = 5;
if (jump and jumpBuffer > 0) {
	vAcceleration -= jumpStrength;
	jumpBuffer = 0;
}
jumpBuffer--;
jumpBuffer = max(0, jumpBuffer);

moveAndCollide();

if (hasPath) {
	if (inTargetGrid) {
		var newArray = array_create(0, 0);
		for (var i = 1; i < array_length(arrPath); i++) array_push(newArray, arrPath[i]);
		arrPath = newArray;
	}
}