/// @description Insert description here
// You can write your code in this editor

event_inherited();

jumpTarget = GRID_SIZE/2;
moveSpeed = 18;

hAcceleration = random(moveSpeed) - moveSpeed/2;
vAcceleration = -random(jumpStrengthFromTarget(jumpTarget, grav));

itemStats = {
	item : noone
}

image_xscale = 0.5;
image_yscale = 0.5;
image_speed = 0;