/// @description Insert description here
// You can write your code in this editor

event_inherited();

age = 0;

jumpTarget = GRID_SIZE/2;
initSpeed = 18;

hAcceleration = random(initSpeed) - initSpeed/2;
vAcceleration = -random(jumpStrengthFromTarget(jumpTarget, grav));

item = {};

image_xscale = 0.75;
image_yscale = 0.75;
image_speed = 0;