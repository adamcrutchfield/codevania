/// @ function		approach(_value, _target, _amount);
/// @ param {real}	_value
/// @ param {real}	_target
/// @ param {real}	_amount
/// @ description returns a value after it approaches a target, does not overshoot
function approach(_value, _target, _amount){
	if (_value < _target) {
		_value += _amount;
		if (_value > _target) return _target; 
	} else {
		_value -= _amount;
		if (_value < _target) return _target; 
	}
	return _target;
}

/// @ function			print(_input);
/// @param	{string}	_input
function print(_input) {
	show_debug_message(_input);
}

/// @ description returns a value that waves bedtween two points
function wave(from, to, duration, offset) {
	var a4 = (to - from) * 0.5;
	return from + a4 + sin((((current_time * 0.001) + duration * offset) / duration) * (pi/2)) * a4;
}

/// @ description returns a value that waves bedtween two points, relative to age
function waveAge(from, to, duration, offset, age) {
	var a4 = (to - from) * 0.5;
	return from + a4 + sin((((age * 0.1) + duration * offset) / duration) * (pi/2)) * a4;
}