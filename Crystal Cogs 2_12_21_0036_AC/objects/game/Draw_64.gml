/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(12, 12, 12 + array_length(arrMachinesGUI) * 48, 68, false);
draw_set_color(c_white);
draw_set_alpha(1);

for (var i = 0; i < array_length(arrMachinesGUI); i++) {
	draw_sprite(object_get_sprite(arrMachinesGUI[i]), 0, 32 + (i * 48), 32);
	draw_text(16 + (i * 48), 48, i + 1);
}