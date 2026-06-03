/// @desc Control cursor position
#region DELETE - USED FOR DEMO
if (keyboard_check_pressed(ord("1"))) global.pressedView 	= !global.pressedView;
if (keyboard_check_pressed(ord("2"))) global.heldView 		= !global.heldView;
if (keyboard_check_pressed(ord("3"))) global.releasedView 	= !global.releasedView;
#endregion

if (useGamepad) {
	// Increase based on gamepad pos
	if (array_length(devices) > 0) {
		var _hA = gamepad_axis_value(devices[0], gp_axislh);
		var _vA = gamepad_axis_value(devices[0], gp_axislv);
		
		DMX += gamepadUIMult * sign(_hA) * abs(_hA * _hA);	
		DMY += gamepadUIMult * sign(_vA) * abs(_vA * _vA);	
	}
} else {
	DMX = device_mouse_x_to_gui(0);
	DMY = device_mouse_y_to_gui(0);
}

if (useGamepad) {
	DMX = clamp(DMX, 0, DW);
	DMY = clamp(DMY, 0, DH);
}
