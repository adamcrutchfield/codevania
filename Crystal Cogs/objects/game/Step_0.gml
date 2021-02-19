/// @description 

global.secondsPassed = delta_time / 1000000;

//init all input controls
var esc = keyboard_check_pressed(vk_escape);

if (esc) {
	window_set_fullscreen(!window_get_fullscreen());
}