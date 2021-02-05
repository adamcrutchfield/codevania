/// @description 

global.secondsPassed = delta_time / 1000000;

//init all input controls
var lClick = mouse_check_button_pressed(mb_left);
var rClick = mouse_check_button_pressed(mb_right);
var spacebar = keyboard_check_pressed(vk_space);

var numKeys = array_create(10, false);
for (var i = 0; i < 10; i++) numKeys[i] = keyboard_check_pressed(ord(string(i + 1)));

var del = keyboard_check_pressed(vk_delete);

gridTargetX = round(mouse_x / 32) * 32;
gridTargetY = round(mouse_y / 32) * 32;

var machineTouching = instance_position(gridTargetX, gridTargetY, objMachine);
var arrowTouching = instance_position(mouse_x, mouse_y, objUIArrow);

var onMachine = (machineTouching != noone);
var onUIArrow = (arrowTouching != noone);

if (lClick) {
	//select arrow, edit machine
	if (onUIArrow) {
		with (arrowTouching) {
			with (machine) {
				switch (object_index) {
					case objRefractor:
					case objMirror:
						if (x < other.x) {	//spin right
							direction -= 22.5;
						} else {	//otherwise, spin left
							direction += 22.5;
						}
						break;
					case objCrystal:
						if (!arrLasers[other.direction / 45]) {
							arrLasers[other.direction / 45] = true;
							numActiveLasers++;
						}
						instance_destroy(objUIArrow);
						break;
					case objReciever:
					default:
				
						break;
				}
			}
		}
	} else {
		//select machine, spawn arrows
		instance_destroy(objUIArrow);
		if (onMachine) with (machineTouching) spawnSelectionArrows();
	}
}


if (onUIArrow) with (arrowTouching) isHovered = true;

//spawn machines
for (var i = 0; i <= 9; i++) {
	if (numKeys[i]) {
		if (!onMachine and i < array_length(arrMachinesGUI)) {
			instance_create_layer(gridTargetX, gridTargetY, "Machines", arrMachinesGUI[i]);
		} else {
			if ( onMachine and machineTouching.object_index == objRefractor and i < NUM_COLORS) {
				//change color of refractor
				with machineTouching color = i;
			}
		}
		instance_destroy(objUIArrow);
	}
}

//destroy machines
if (del) {
	if (onMachine) {
		instance_destroy(machineTouching);
	}
	instance_destroy(objUIArrow);
}


//deactivate lasers on target machine
if (rClick) {
	if (machineTouching != noone) with (machineTouching) {
		for (var i = 0; i < 8; i++) arrLasers[i] = false;
		numActiveLasers = 0;
	}
	instance_destroy(objUIArrow);
}

if (spacebar) {
	//give machine info
}
