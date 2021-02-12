/// @ function					gridMove();
/// @ param	{real}	_direction	the direction to move
/// @ description move one space along a grid given a direction
function gridMove(_direction){
	if (_direction < 180 and _direction > 0) y -= GRID_SIZE;	//up
	if (_direction > 180 or _direction < 0) y += GRID_SIZE;	//down
	if (_direction > 90 and _direction < 270) x -= GRID_SIZE;	//left
	if (_direction < 90 or _direction > 270) x += GRID_SIZE;	//right
}