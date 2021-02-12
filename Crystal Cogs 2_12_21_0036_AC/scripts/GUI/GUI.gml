function spawnGUI() {
	instance_destroy(objUIArrow);
	switch (object_index) {
		case objRefractor:
			with (instance_create_depth(x, y, -10, objUIButton)) {
				machine = other;
				direction = 90;
				gridMove(direction);
				isToggled = other.isInverted;
			}
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