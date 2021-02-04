/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//activate only if recieving 2 or more red and none of any other color
active = (arrLight[lightColors.red] >= 2);
if (active) {
	for (var i = 0; i < NUM_COLORS; i++) {
		if (i != lightColors.red) active = (arrLight[i] == 0);
	}
}