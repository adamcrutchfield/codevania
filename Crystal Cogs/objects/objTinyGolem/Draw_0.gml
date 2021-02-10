/// @description Insert description here
// You can write your code in this editor

draw_self();

var x1 = x;
var y1 = y;

for (var i = 0; i < array_length(arrPath); i++) {
	draw_circle(arrPath[i].x, arrPath[i].y, 4, false);
	if (i > 0) {
		x1 = arrPath[i-1].x;
		y1 = arrPath[i-1].y;
	}
	draw_line_width_color(x1, y1, arrPath[i].x, arrPath[i].y, 4, c_white, c_gray);
}