/// @description Insert description here
// You can write your code in this editor
global.secondsPassed = delta_time / 1000000;
var lClick = mouse_check_button_pressed(mb_left);
var enter = keyboard_check_pressed(vk_enter);

if enter {
	global.consoleShown = !global.consoleShown;
}

if lClick {
	objPlayer.x = mouse_x;
	objPlayer.y = mouse_y;
}