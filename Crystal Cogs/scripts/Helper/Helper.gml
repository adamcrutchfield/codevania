/// @ function		approach(_value, _target, _amount)
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