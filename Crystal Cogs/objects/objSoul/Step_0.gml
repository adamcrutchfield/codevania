/// @description change states and move

//register inputs
var left = keyboard_check(ord("A"));
var right = keyboard_check(ord("D"));
var up = keyboard_check(ord("W"));
var down = keyboard_check(ord("S"));
var lClick = mouse_check_button_pressed(mb_left);

switch state {
	case soulStates.free:
	
		//reset occupied golem to none
		occupiedGolem = noone;
		
		//move
		var directionH = right - left;
		var directionV = down - up;
		
		hAcceleration = directionH * moveSpeed;
		vAcceleration = directionV * moveSpeed;
	
		moveAndCollide();
		
		//when near a golem that's clicked on, begin to enter it
		if (lClick) {
			var targetGolem = instance_position(mouse_x, mouse_y, objGolem);
			if (targetGolem != noone and distance_to_point(targetGolem.x, targetGolem.y) <= GRID_SIZE*3) {
				occupiedGolem = targetGolem;
				state = soulStates.movingToGolem;
			}
		}
		
		break;
	case soulStates.movingToGolem:
		
		//move towards golem
		x = lerp(x, occupiedGolem.x, 0.2);
		y = lerp(y, occupiedGolem.y+GRID_SIZE, 0.2);
		
		//once close enough, enter golem
		if (point_distance(x, y, occupiedGolem.x, occupiedGolem.y+GRID_SIZE) <= 2) state = soulStates.inGolem;
		
		break;
	case soulStates.inGolem:
		
		//reset speed so you won't retain momentum from before entering the golem
		hSpeed = 0;
		vSpeed = 0;
		
		//change golem state
		with(occupiedGolem) state = golemStates.hasSoul;
		
		//stay near golem
		x = lerp(x, occupiedGolem.x, 0.8);
		y = lerp(y, occupiedGolem.y+GRID_SIZE, 0.8);
		
		//exit golem
		if (lClick) state = soulStates.exitingGolem;
		
		break;
	case soulStates.exitingGolem:
		
		//move up
		vAcceleration = -20;
		moveAndCollide();
		
		//change states
		with(occupiedGolem) state = golemStates.empty;
		state = soulStates.free;
		
		break;
}