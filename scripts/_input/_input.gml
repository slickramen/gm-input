/// @desc Input functions

// Collect the input from a given key
function collect_input(_type, _keyId) {
	switch (_type) {
		case "keyboard":
			var _val = keyboard_check(_keyId);
			if (_val) {
				useGamepad = false;	
			}
			
			return _val;
			
		case "mouse":
			var _val = mouse_check_button(_keyId);
			if (_val) {
				useGamepad = false;	
			}
			
			return _val;
			
		case "mouse_wheel":
			var _val = false;
			if (_keyId == "wheel_up") {
				_val = mouse_wheel_up();
			} else if (_keyId == "wheel_down") {
				_val = mouse_wheel_down();
			}
			
			if (_val) {
				useGamepad = false;	
			}
			
			return _val;
			
		case "gamepad":
			if (array_length(devices) > 0) {
				var _val = gamepad_button_check(devices[0], _keyId);
				if (_val) {
					useGamepad = true;	
				}
				return _val;
			}
			
			return false;
			
		case "gamepad_axis":
			if (array_length(devices) > 0) {
				var _val = 0, _min = 0, _max = 0;
				var _inputMacro = -1;

				switch (_keyId) {
					case gp_axislh_left:
						_inputMacro = gp_axislh;
						_min = -1;
						_max = 0;
						break;
					case gp_axislh_right:
						_inputMacro = gp_axislh;
						_min = 0;
						_max = 1;
						break;
					case gp_axislv_up:
						_inputMacro = gp_axislv;
						_min = -1;
						_max = 0;
						break;
					case gp_axislv_down:
						_inputMacro = gp_axislv;
						_min = 0;
						_max = 1;
						break;
					case gp_axisrh_left:
						_inputMacro = gp_axisrh;
						_min = -1;
						_max = 0;
						break;
					case gp_axisrh_right:
						_inputMacro = gp_axisrh;
						_min = 0;
						_max = 1;
						break;
					case gp_axisrv_up:
						_inputMacro = gp_axisrv;
						_min = -1;
						_max = 0;
						break;
					case gp_axisrv_down:
						_inputMacro = gp_axisrv;
						_min = 0;
						_max = 1;
						break;
				}
				
				if (_inputMacro != -1) {
					var _val = clamp(gamepad_axis_value(devices[0], _inputMacro), _min, _max);	
					if (_val != 0) {
						useGamepad = true;	
					}
				}
				
				return _val;
			}
			
			return false;
	}
	
	return 0;
}

/// @desc input_key(_type, _id, _keyId, _name, _sprite, _index) constructor
function input_key(_type, _id, _keyId, _name, _sprite, _index) constructor {
	type = _type;
	id = _id;
	keyId = _keyId;
	name = _name;
	sprite = _sprite;
	index = _index;
	
	// Key functions
	reset = true;
	pressed = false;
	held = false;
	released = false;
	
	// Rebind
	function check_input() { 
		// Reset released
		released = false;
		
		// Check if pressed
		if (type == "gamepad_axis") {
			var _inputAmt = abs(collect_input(type, keyId));
			if (_inputAmt > 0.05) {
				// Single fire the pressed
				if (!pressed) {
					// Turn off reset
					if (reset) {
						pressed = true;
						reset = false;
					}
				} else {
					pressed = false;	
				}
			
				// Continued hold
				held = _inputAmt;
			} else {
				pressed = false;
				held = false;
				released = !reset;
				reset = true;
			}
		} else {
			if (collect_input(type, keyId)) {
				// Single fire the pressed
				if (!pressed) {
					// Turn off reset
					if (reset) {
						pressed = true;
						reset = false;
					}
				} else {
					pressed = false;	
				}
			
				// Continued hold
				held = true;
			} else {
				pressed = false;
				held = false;
				released = !reset;
				reset = true;
			}
		}
	}
}

/// @desc input_master() constructor
function input_master() constructor {
	keyList = [];
	
	static add = function(_inputKey){
		self.keyList[_inputKey.id] = _inputKey;
		return self;
	};
}

/// @desc fetch_input(input)
function fetch_input(_input) {
	var _inputBinding = -1;
	
	// Map string to an input
	if (variable_struct_exists(obj_controlBinding.inputs, _input)) {
		_inputBinding = variable_struct_get(obj_controlBinding.inputs, _input);	
	}
	
	return _inputBinding;
}

/// @desc fetch_input_key(inputBinding, inputNum)
function fetch_input_key(_inputBinding, _inputNum) {
	// Return input
	if (_inputBinding != -1) {
		if (_inputNum >= 0 && _inputNum < array_length(_inputBinding) 
				&& _inputBinding[_inputNum] >= 0 
					&& _inputBinding[_inputNum] < array_length(obj_controlBinding.masterKey.keyList)) {
			// We found the key
			return obj_controlBinding.masterKey.keyList[_inputBinding[_inputNum]];
		}
	}
	
	// Didn't find
	return -1;	
}

/// @desc input_check(input)
function input_check(_input) {
	var _inputBinding = fetch_input(_input);
	var _output = 0;
	
	// Return read value else return 0 if not found
	if (_inputBinding != -1) {
		
		// Loop through keys and check for input
		for (var i = 0; i < array_length(_inputBinding); i++) {
			var _ik = fetch_input_key(_inputBinding, i);
		
			// If key is bound and held
			if (_ik != -1 && _ik.held != 0) {
				_output = _ik.held;
				break;
			}
		}
	}
	
	return _output;
}

/// @desc input_check_pressed(input)
function input_check_pressed(_input) {
	var _inputBinding = fetch_input(_input);
	var _output = 0;
	
	// Return read value else return 0 if not found
	if (_inputBinding != -1) {
		// Loop through keys and check for input
		for (var i = 0; i < array_length(_inputBinding); i++) {
			var _ik = fetch_input_key(_inputBinding, i);
			
			// If key is bound and pressed
			if (_ik != -1 && _ik.pressed != 0) {
				_output = _ik.pressed;
				break;
			}
		}
	}
	
	return _output;
}

/// @desc input_check_released(input)
function input_check_released(_input) {
	var _inputBinding = fetch_input(_input);
	var _output = 0;
	
	// Return read value else return 0 if not found
	if (_inputBinding != -1) {
		// Loop through keys and check for input
		for (var i = 0; i < array_length(_inputBinding); i++) {
			var _ik = fetch_input_key(_inputBinding, i);
			
			// If key is bound and released
			if (_ik != -1 && _ik.released != 0) {
				_output = _ik.released;
				break;
			}
		}
	}
	
	return _output;
}

/// @desc set_control_visible(control, visible)
function set_control_visible(_control, _visible) {
	var _found = -1;
	for (var i = 0; i < array_length(obj_controlBinding.controlListings); i++) {
		if (obj_controlBinding.controlListings[i][1] == _control) {
			_found = i;
			break;
		}
	}
	
	// Check if we found
	if (_found != -1) {
		if (obj_controlBinding.controlListings[_found][0] == false && _visible) obj_controlBinding.numDisp++;
		obj_controlBinding.controlListings[_found][0] = _visible;
	}
}
	
/// @desc find_used_input(inputBinding)
function find_used_input(_inputBinding=-1) {
	var _usedInput = -1;
	// Return read value else return 0 if not found
	if (_inputBinding != -1) {
		// Loop through keys and check for input
		for (var j = 0; j < array_length(_inputBinding); j++) {
			var _ik = fetch_input_key(_inputBinding, j);
		
			// If key is bound
			if (_ik != -1) {
				// If using gamepad, get gamepad option
				if (useGamepad) {
					if (_ik.type == "gamepad" || _ik.type == "gamepad_axis") {
						_usedInput = _ik;
						break;
					}
				} else {
					if (_ik.type == "keyboard" || _ik.type == "mouse") {
						_usedInput = _ik;
						break;
					}
				}
			}
		}
	}
	
	return _usedInput;
}

/// @desc draw_input_sprite(input, xx, yy)
function draw_input_sprite(_input, _xx, _yy) {
	var _inputBinding = fetch_input(_input);
	var _usedInput = find_used_input(_inputBinding);
	
	// Draw if found
	if (_usedInput != -1) {
		var _sprite = _usedInput.sprite;
		var _index = _usedInput.index;
		
		// Draw
		draw_sprite(_sprite, _index, _xx, _yy);
		
		// Draw key
		if (_usedInput.type == "keyboard") {
			draw_text(_xx + 28, _yy + 20, _usedInput.name);	
		}	
	}
}
