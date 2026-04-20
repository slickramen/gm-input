# gm-input
## About

An open-source GameMaker input library used to easily add input binding and controller support to your GameMaker project. This supports features such as:
- Keyboard and Controller layouts
- Multiple keybindings
- Displaying relevant inputs on screen
- Drop-in replacements for `keyboard_check`, `keyboard_check_pressed` and `keyboard_check_released`.

## Installation

Currently, this repository only contains the source code. In the future, I will include a downloadable extension to allow for quick and easy setup.

## How to set up

The list of user inputs is defined in `obj_controlBinding`. The list looks like this:
```
// Player input and controls
inputs = {
	left		    : [binding_keyboard.a,				  binding_xbox.dpad_left,		binding_xbox.lstick_left],
	right		    : [binding_keyboard.d,				  binding_xbox.dpad_right,	binding_xbox.lstick_right],
	up			    : [binding_keyboard.w,				  binding_xbox.dpad_up,		  binding_xbox.lstick_up],
	down		    : [binding_keyboard.s,				  binding_xbox.dpad_down,		binding_xbox.lstick_down],
				
	sprint		  : [binding_keyboard.shift,			binding_xbox.lstick_press],

	shoot		    : [binding_keyboard.lmb,			  binding_xbox.rt],
	aim		      : [binding_keyboard.rmb,			  binding_xbox.lt],
	swapWeapon  : [binding_keyboard.space,		  binding_xbox.west],
	
	clickUI		  : [binding_keyboard.lmb,			  binding_xbox.rstick_press],
	interact	  : [binding_keyboard.e,			    binding_xbox.south],
	close		    : [binding_keyboard.q,				  binding_xbox.east],
	pause		    : [binding_keyboard.escape, 		binding_xbox.start],
}
```

Each entry consists of a key-value pair. The key is the ID of the input, such as "sprint", "shoot", "interact", etc. The value is a list of input bindings (multiple keyboard keys or gamepad buttons can be bound to the same input ID).

## How to use

As mentioned above, there are drop-in replacements for `keyboard_check`, `keyboard_check_pressed` and `keyboard_check_released`. To check for a given input, you can use one of the following functions:
- `input_check(<input-id>)` - `keyboard_check` equivalent
- `input_check_pressed(<input-id>)` - `keyboard_check_pressed` equivalent
- `input_check_released(<input-id>)` - `keyboard_check_released` equivalent

where `<input-id>` is the ID of the input that you want to check.

## Acknowledgements

The icons used for the controller layouts are from the Kenney Input Prompts asset pack.
https://kenney.nl/assets/input-prompts
