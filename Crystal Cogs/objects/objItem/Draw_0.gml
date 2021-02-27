/// @description Insert description here
// You can write your code in this editor

var yOffset = -waveAge(0, 5, 1, 0, age);

var drawColor = item.getItemRGB();
draw_sprite_ext(sprite_index, image_index, x, y+yOffset, image_xscale, image_yscale, image_angle, drawColor, 1);

//draw item count
if (item.count > 1) {
	draw_set_color(c_black);
	draw_text(x-15, y-1, item.count);
	draw_set_color(c_white);
	draw_text(x-16, y-2, item.count);
}