/// @description Insert description here
// You can write your code in this editor

//show target grid tile
var x1 = global.gridTargetX - GRID_SIZE / 2;
var y1 = global.gridTargetY - GRID_SIZE / 2;
var x2 = x1 + GRID_SIZE - 1;
var y2 = y1 + GRID_SIZE - 1;

draw_set_color(c_black);
draw_rectangle(x1, y1, x2, y2, true);
draw_set_color(c_white);

//draw cursor
//draw_sprite(sprMouse, 0, mouse_x, mouse_y);

//display machines' stored light and water
var numMachines = instance_number(objMachine);
for (var i = 0; i < numMachines; i++) {
	var machine = instance_find(objMachine, i);
	with (machine) {
		//light
		for (var j = 0; j < NUM_COLORS; j++) {
			draw_set_color(drawLightColor(j));
			var x1 = x - 16 + ((j + 1) * 4);
			var y1 = y - 16;
			var x2 = x1;
			var y2 = (y1 - (arrLight[j]));
			draw_line_width(x1, y1, x2, y2, 2);
			draw_set_color(c_white);
		}
		
		//water
		var x1 = x - 16;
		var y1 = y + 16;
		var x2 = x1;
		var y2 = y1 - (32 * (water / waterMax));
		draw_line_width_color(x1, y1, x2, y2,  4, c_teal, c_teal);

		//draw_text(x - 16, y + 16, string(water) + "/" + string(waterMax));
	}
}