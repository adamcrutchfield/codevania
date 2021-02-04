// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function spawnSelectionArrows() {
	instance_destroy(objUIArrow);
	switch (object_index) {
		case objRefractor:
		case objMirror:
				with (instance_create_depth(x, y, -10, objUIArrow)) {
					machine = other;
					direction = 0;
					image_angle = direction;
					gridMove(direction);
				}
				with (instance_create_depth(x, y, -10, objUIArrow)) {
					machine = other;
					direction = 180;
					image_angle = direction;
					gridMove(direction);
				}
			break;
		case objCrystal:
			for (var i = 0; i < 8 ; i++) {
				with (instance_create_depth(x, y, -10, objUIArrow)) {
					machine = other;
					direction = i * 45;
					image_angle = direction;
					gridMove(direction);
				}
			}
			break;
		case objReciever:
		default:
				
			break;
	}
}