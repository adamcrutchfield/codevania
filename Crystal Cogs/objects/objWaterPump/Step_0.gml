/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//activate only if recieving color 80+% cyan
active = compareColors(arrLight, 0, 1, 1) >= 0.8;

transferWater();

if (active and place_meeting(x, y, objWaterfall)) water+=1;	//if active, draw water
water = clamp(water, 0, waterMax);	//don't let water go higher than max

