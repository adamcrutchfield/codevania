/// @description Insert description here
// You can write your code in this editor

var left = keyboard_check(ord("A"));
var right = keyboard_check(ord("D"));
var up = keyboard_check(ord("W"));
var down = keyboard_check(ord("S"));

var lClick = mouse_check_button_pressed(mb_left);

switch state {
	case soulStates.free:
		
		var directionH = right - left;
		var directionV = down - up;
		
		hAcceleration = directionH * moveSpeed;
		vAcceleration = directionV * moveSpeed;
	
		moveAndCollide();
		
		if (lClick) {
			var targetGolem = instance_position(mouse_x, mouse_y, objGolem);
			if (targetGolem != -1 and distance_to_point(targetGolem.x, targetGolem.y) <= 100) {
				occupiedGolem = targetGolem;
				state = soulStates.movingToGolem;
			}
		}
		
		break;
	case soulStates.movingToGolem:
	
		x = lerp(x, occupiedGolem.x, 0.2);
		y = lerp(y, occupiedGolem.y, 0.2);
		
		if (point_distance(x, y, occupiedGolem.x, occupiedGolem.y) <= 2) state = soulStates.inGolem;
		
		break;
	case soulStates.inGolem:
	
		with(occupiedGolem) state = golemStates.hasSoul;
		
		x = lerp(x, occupiedGolem.x, 0.8);
		y = lerp(y, occupiedGolem.y, 0.8);
		
		if (lClick) {
			with(occupiedGolem) state = golemStates.empty;
			state = soulStates.free;
		}
		
		break;
	default: break;
}