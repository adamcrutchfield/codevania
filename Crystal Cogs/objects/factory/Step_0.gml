/// @description Insert description here
// You can write your code in this editor

//init all input controls
var lClick = mouse_check_button_pressed(mb_left);
var rClick = mouse_check_button_pressed(mb_right);
var del = keyboard_check_pressed(vk_delete);
var numKeys = array_create(10, false);
for (var i = 0; i <= 9; i++) numKeys[i] = keyboard_check_pressed(ord(string(i + 1)));

mouseGridX = round(mouse_x / GRID_SIZE) * GRID_SIZE;
mouseGridY = round(mouse_y / GRID_SIZE) * GRID_SIZE;

var solidTouching = instance_position(mouseGridX, mouseGridY, objSolid);
var machineTouching = instance_position(mouseGridX, mouseGridY, objMachine);
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

for (var i = 0; i <= 9; i++) {
	if (numKeys[i]) {
		//spawn machines
		if (!onSolid and i < array_length(arrMachinesGUI)) {
			instance_create_layer(mouseGridX, mouseGridY, "Machines", arrMachinesGUI[i]);
			onSolid = true;
		} else {	//change color of refractor
			if ( onMachine and machineTouching.object_index == objRefractor and i < NUM_COLORS) {
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
		dropMachine(machineTouching);
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