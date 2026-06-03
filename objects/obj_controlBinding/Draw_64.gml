/// @desc Debug draw controls
display_set_gui_size(DW, DH);

draw_set_font(fnt_text);
draw_set_colour(c_white);

// Draw listed controls
var _inc = 0;
for (var i = 0; i < array_length(controlListings); i++) {
	if (controlListings[i][0] == false) continue;
	var _sprite = spr_controlsKey, _index = 0;
	
	var _inputBinding = fetch_input(controlListings[i][2]);
	var _usedInput = find_used_input(_inputBinding);
	
	var _controlX = 32;
	var _controlY = DH - 80 - (80 * numDisp) + 80 * _inc;
	
	// Check that binding is valid
	if (_usedInput != -1) {
		_sprite = _usedInput.sprite;
		_index = _usedInput.index;
		var _pad = 18;
		
		// Draw
		draw_sprite(_sprite, _index, _controlX, _controlY);
		
		// Draw key
		if (_usedInput.type == "keyboard") {
			draw_set_colour(c_black);
			draw_set_font(fnt_keyboardText);
			
			draw_text(_controlX + 28, _controlY + 20, _usedInput.name);	
			
			draw_set_font(fnt_text);
			draw_set_colour(c_white);
		}
		
		draw_text(_controlX + 74, _controlY + _pad, controlListings[i][1]);
	} else {
		// ::DEBUG:: - Draw null	
		draw_text(_controlX + 74, _controlY + _pad, "NOT FOUND!!!");
	}
	
	_inc++;
}

if (!global.keyDebug) exit;
	
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

var _msg = $"Debug viewer (turn off global.keyDebug to hide)\nPress '1' to toggle pressed view {global.pressedView ? "off" : "on"}\nPress '2' to toggle held view {global.heldView ? "off" : "on"}\nPress '3' to toggle released view {global.releasedView ? "off" : "on"}"

draw_text(DW - 16, DH - 16, _msg);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Draw pressed inputs
var _drawX = 8;
var _drawY = 8;
var _drawPad = 52;

for (var i = 0; i < array_length(masterKey.keyList); i++) {
	if (!masterKey.keyList[i]) continue;
	
	var _inputEnabled = false;
	
	_inputEnabled = _inputEnabled || (global.pressedView && masterKey.keyList[i].pressed);
	_inputEnabled = _inputEnabled || (global.heldView && masterKey.keyList[i].held);
	_inputEnabled = _inputEnabled || (global.releasedView && masterKey.keyList[i].released);
	
	if (_inputEnabled) {
		// Draw
		var _keySprite = masterKey.keyList[i].sprite;
		var _index = masterKey.keyList[i].index;
		
		var _keyCol = c_white;
		
		if (global.pressedView && masterKey.keyList[i].pressed) {
			_keyCol = c_lime;
		}
		
		if (global.releasedView && masterKey.keyList[i].released) {
			_keyCol = c_red;
		}
		
		draw_sprite_ext(_keySprite, _index, _drawX, _drawY, 1, 1, 0, _keyCol, 1);
		
		// Draw key
		if (masterKey.keyList[i].type == "keyboard") {
			draw_set_colour(c_black);
			draw_set_font(fnt_keyboardText);
			
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			
			draw_text(_drawX + sprite_get_width(spr_controlsKey)/2, 
				_drawY + sprite_get_height(spr_controlsKey)/2, 
				masterKey.keyList[i].name);	
			
			draw_set_colour(c_white);
			draw_set_font(fnt_text);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		}
		
		draw_text(_drawX + 74, _drawY + 18, masterKey.keyList[i].name);
		_drawY += _drawPad;
	}
}