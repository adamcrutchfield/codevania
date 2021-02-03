/// @description

if global.consoleShown {
	var x1 = 16;
	var y1 = 16;
	var x2 = x1 + 32 * 10;
	var y2 = y1 + 32 * 2;
	
	draw_set_alpha(0.8);
	draw_set_color(c_black);
	draw_rectangle(x1, y1, x2, y2, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
}