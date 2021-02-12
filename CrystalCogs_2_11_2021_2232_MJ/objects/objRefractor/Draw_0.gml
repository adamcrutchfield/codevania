/// @description Insert description here
// You can write your code in this editor

image_angle = direction - 45;

var drawColor = drawLightColor(color);
if (isInverted) {
	switch color {
		case lightColors.red: drawColor = make_color_rgb(0, 255, 255); break;
		case lightColors.green: drawColor = make_color_rgb(255, 0, 255); break;
		case lightColors.blue: drawColor = make_color_rgb(255, 255, 0); break;
	}
}

draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, image_angle, drawColor, 1);
//draw_line_color(x, y, x+16, y, c_red, c_red);
//draw_text(x, y, color);