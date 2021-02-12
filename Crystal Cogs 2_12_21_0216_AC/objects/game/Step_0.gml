/// @description 

global.secondsPassed = delta_time / 1000000;

//init all input controls
var lClick = mouse_check_button_pressed(mb_left);
var rClick = mouse_check_button_pressed(mb_right);
var spacebar = keyboard_check_pressed(vk_space);
var esc = keyboard_check_pressed(vk_escape);

var numKeys = array_create(10, false);
for (var i = 0; i < 10; i++) numKeys[i] = keyboard_check_pressed(ord(string(i + 1)));

var del = keyboard_check_pressed(vk_delete);

global.gridTargetX = round(mouse_x / GRID_SIZE) * GRID_SIZE;
global.gridTargetY = round(mouse_y / GRID_SIZE) * GRID_SIZE;

var solidTouching = instance_position(global.gridTargetX, global.gridTargetY, objSolid);
var machineTouching = instance_position(global.gridTargetX, global.gridTargetY, objMachine);
var arrowTouching = instance_position(mouse_x, mouse_y, objUIArrow);
var buttonTouching = instance_position(mouse_x, mouse_y, objUIButton);

var onSolid = (solidTouching != noone);
var onMachine = (machineTouching != noone);
var onUIArrow = (arrowTouching != noone);
var onUIButton = (buttonTouching != noone);

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
	} else if (onUIButton) {
		with (buttonTouching) {
			isToggled = !isToggled;
			if (machine.object_index == objRefractor) machine.isInverted = !machine.isInverted;
		}
	} else {
		//select machine, spawn arrows
		instance_destroy(objUIArrow);
		instance_destroy(objUIButton);
		if (onMachine) with (machineTouching) spawnGUI();
	}
}

if (onUIArrow) with (arrowTouching) isHovered = true;
if (onUIButton) with (buttonTouching) isHovered = true;

//spawn machines
for (var i = 0; i <= 9; i++) {
	if (numKeys[i]) {
		if (!onSolid and i < array_length(arrMachinesGUI)) {
			instance_create_layer(global.gridTargetX, global.gridTargetY, "Machines", arrMachinesGUI[i]);
			onSolid = true;
		} else {
			if ( onMachine and machineTouching.object_index == objRefractor and i < NUM_COLORS) {
				//change color of refractor
				with machineTouching color = i;
			}
		}
		instance_destroy(objUIArrow);
		instance_destroy(objUIButton);
	}
}

//destroy machines
if (del) {
	if (onMachine) {
		dropMachineAsItem(machineTouching);
	}
	instance_destroy(objUIArrow);
	instance_destroy(objUIButton);
}


//deactivate lasers on target machine
if (rClick) {
	if (machineTouching != noone) with (machineTouching) {
		for (var i = 0; i < 8; i++) arrLasers[i] = false;
		numActiveLasers = 0;
	}
	instance_destroy(objUIArrow);
	instance_destroy(objUIButton);
}

if (spacebar) {
	//instance_create_layer(global.gridTargetX, global.gridTargetY, "Entities", objItem);
}

if (esc) {
	window_set_fullscreen(!window_get_fullscreen());
}
