/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//activate only if recieving 2 or more blue and none of any other color, and only if on a mineral spring
active = (arrLight[lightColors.blue] >= 2 and position_meeting(x, y, objMineralSpring));
if (active) {
	for (var i = 1; i < NUM_COLORS; i++) {
		if (i != lightColors.blue) active = (arrLight[i] == 0);
	}
}

if (active) water+=1;	//if active, draw water
water = clamp(water, 0, waterMax);	//don't let water go higher than max

transferWater();