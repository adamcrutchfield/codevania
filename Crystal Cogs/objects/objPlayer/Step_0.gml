/// @description

var left = keyboard_check(ord("A"));
var right = keyboard_check(ord("D"));
//var up = keyboard_check(ord("W"));
//var down = keyboard_check(ord("S"));
var jump = keyboard_check_pressed(vk_space);

switch state {
	case playerStates.idle:
		moveAndCollide(left, right, jump);
		break;
	default: break;
}

if (y > room_height + 100) room_restart();