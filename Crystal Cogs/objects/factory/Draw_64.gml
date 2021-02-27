/// @description Insert description here
// You can write your code in this editor

/*
//draw machines gui
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

//draw machines gui 
for (var i = 0; i < array_length(arrMachinesGUI); i++) {
	
	//get draw location
	var drawX = GRID_SIZE + (i * 34);
	var drawY = GRID_SIZE;
	
	//draw slot
	draw_sprite_ext(sprSlot, 0, drawX, drawY,  1, 1, 0, c_white, 0.8);
	
	//drqaw sprite
	draw_sprite_ext(object_get_sprite(arrMachinesGUI[i]), 0, drawX, drawY, 1, 1,  0, c_white, 1);
	
	//draw number
	draw_set_color(c_black);
	draw_text(drawX-15, drawY-1, i+1);
	draw_set_color(c_white);
	draw_text(drawX-16, drawY-2, i+1);
}


//draw inventory 
for (var i = 0; i < inventory.size; i++) {
	
	//get draw location
	var drawX = GRID_SIZE + (i * 34);
	var drawY = camera_get_view_height(0) - GRID_SIZE;
	
	//draw slot
	draw_sprite_ext(sprSlot, 0, drawX, drawY,  1, 1, 0, c_white, 0.8);
	
	//if item exists
	var currentItem = inventory.items[| i];
	if (currentItem != undefined and variable_struct_exists(currentItem, "sprite")) {
		//draw item
		var drawColor = currentItem.getItemRGB();
		draw_sprite_ext(currentItem.sprite, 0, drawX, drawY, 1, 1,  0, drawColor, 1);
		
		//draw item count
		//if (currentItem.count != 1) {
			draw_set_color(c_black);
			draw_text(drawX-15, drawY-1, currentItem.count);
			draw_set_color(c_white);
			draw_text(drawX-16, drawY-2, currentItem.count);
		//}
	}
}