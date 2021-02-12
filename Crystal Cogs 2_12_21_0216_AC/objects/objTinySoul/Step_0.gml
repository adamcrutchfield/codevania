/// @description Insert description here
// You can write your code in this editor

//var lClick = mouse_check_button_pressed(mb_left);
var rClick = mouse_check_button_pressed(mb_right);

if (rClick) targetMachine = instance_position(mouse_x, mouse_y, objMachine);

if (targetMachine != noone) {
	x = lerp(x, targetMachine.x, 0.2);
	y = lerp(y, targetMachine.y-GRID_SIZE*3/4, 0.2);
}