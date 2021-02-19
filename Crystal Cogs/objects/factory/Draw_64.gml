/// @description Insert description here
// You can write your code in this editor

/*
draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(12, 12, 12 + array_length(arrMachinesGUI) * 48, 68, false);
draw_set_color(c_white);
draw_set_alpha(1);

for (var i = 0; i < array_length(arrMachinesGUI); i++) {
	draw_sprite(object_get_sprite(arrMachinesGUI[i]), 0, 32 + (i * 48), 32);
	draw_text(16 + (i * 48), 48, i + 1);
}
*/

//draw inventory
for (var i = 0; i < ds_list_size(inventory.items); i++) {
	var currentItem = inventory.items[| i];
	if variable_struct_exists(currentItem, sprite) {
		var drawColor = currentItem.getItemRGB();
		draw_sprite_ext(currentItem.sprite, 0, GRID_SIZE, room_height - GRID_SIZE, 1, 1,  0, drawColor, 1);
	}
}