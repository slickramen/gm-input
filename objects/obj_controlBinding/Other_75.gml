var _eventType = async_load[? "event_type"];

var _isDiscovered = _eventType == "gamepad discovered";
var _isLost = _eventType == "gamepad lost";

if (!_isDiscovered && !_isLost)
    exit;

var _gamepadId = async_load[? "pad_index"];

// Discover gamepads
if (_isDiscovered) {
    show_debug_message($"GAMEPAD {_gamepadId} DISCOVERED");
    array_push(devices, _gamepadId);
	
	// Update
	if(gamepad_is_connected(_gamepadId)) gamepad_set_axis_deadzone(_gamepadId, 0.1);
} else {
    show_debug_message($"GAMEPAD {_gamepadId} LOST");
    array_delete(devices, array_get_index(devices, _gamepadId), 1);
}