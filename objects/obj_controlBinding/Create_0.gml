/// @desc Setup

#region DELETE - USED FOR DEMO
global.keyDebug = true;
global.pressedView = true;
global.heldView = true;
global.releasedView = true;
#endregion

depth = -1000;

#macro DW 640
#macro DH 360

globalvar DMX;
globalvar DMY;

DMX = device_mouse_x_to_gui(0);
DMY = device_mouse_y_to_gui(0);
gamepadUIMult = 12;

globalvar devices;
devices = [];

globalvar useGamepad;
useGamepad = false;

enum binding_keyboard {
	a,
	b,
	c,
	d,
	e,
	f,
	g,
	h,
	i,
	j,
	k,
	l,
	m,
	n,
	o,
	p,
	q,
	r,
	s,
	t,
	u,
	v,
	w,
	x,
	y,
	z,
	k0,
	k1,
	k2,
	k3,
	k4,
	k5,
	k6,
	k7,
	k8,
	k9,
	space,
	shift,
	escape,
	lmb,
	rmb,
	mmb,
	wheel_up,
	wheel_down,
	length	
}

enum binding_xbox {
	dpad_up=70,
	dpad_down,
	dpad_left,
	dpad_right,
	north,
	east,
	south,
	west,
	lb,
	lt,
	rb,
	rt,
	lstick_up,
	lstick_down,
	lstick_left,
	lstick_right,
	lstick_press,
	rstick_up,
	rstick_down,
	rstick_left,
	rstick_right,
	rstick_press,
	start,
	length	
}

#macro gp_axislh_left 800
#macro gp_axislh_right 801
#macro gp_axislv_up 802
#macro gp_axislv_down 803
#macro gp_axisrh_left 804
#macro gp_axisrh_right 805
#macro gp_axisrv_up 806
#macro gp_axisrv_down 807

// Setup master keylist
#region set master keys
masterKey = new input_master()
.add(new input_key("keyboard",		binding_keyboard.a,			ord("A"),		"A",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.b,			ord("B"),		"B",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.c,			ord("C"),		"C",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.d,			ord("D"),		"D",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.e,			ord("E"),		"E",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.f,			ord("F"),		"F",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.g,			ord("G"),		"G",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.h,			ord("H"),		"H",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.i,			ord("I"),		"I",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.j,			ord("J"),		"J",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.k,			ord("K"),		"K",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.l,			ord("L"),		"L",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.m,			ord("M"),		"M",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.n,			ord("N"),		"N",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.o,			ord("O"),		"O",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.p,			ord("P"),		"P",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.q,			ord("Q"),		"Q",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.r,			ord("R"),		"R",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.s,			ord("S"),		"S",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.t,			ord("T"),		"T",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.u,			ord("U"),		"U",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.v,			ord("V"),		"V",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.w,			ord("W"),		"W",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.x,			ord("X"),		"X",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.y,			ord("Y"),		"Y",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.z,			ord("Z"),		"Z",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.k0,		ord(0),			"0",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.k1,		ord(1),			"1",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.k2,		ord(2),			"2",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.k3,		ord(3),			"3",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.k4,		ord(4),			"4",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.k5,		ord(5),			"5",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.k6,		ord(6),			"6",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.k7,		ord(7),			"7",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.k8,		ord(8),			"8",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.k9,		ord(9),			"9",			spr_controlsKey,	0))
.add(new input_key("keyboard",		binding_keyboard.space,		vk_space,		"Space",		spr_controlsKey,	1))
.add(new input_key("keyboard",		binding_keyboard.shift,		vk_shift,		"Shift",		spr_controlsKey,	1))
.add(new input_key("keyboard",		binding_keyboard.escape,	vk_escape,		"Escape",		spr_controlsKey,	1))
.add(new input_key("mouse",			binding_keyboard.lmb,		mb_left,		"LMB",			spr_controlsKey,	1))
.add(new input_key("mouse",			binding_keyboard.rmb,		mb_right,		"RMB",			spr_controlsKey,	1))
.add(new input_key("mouse",			binding_keyboard.mmb,		mb_middle,		"MMB",			spr_controlsKey,	1))
.add(new input_key("mouse_wheel",	binding_keyboard.wheel_up,	"wheel_up",		"Wheel Up",		spr_controlsKey,	1))
.add(new input_key("mouse_wheel",	binding_keyboard.wheel_down,"wheel_down",	"Wheel Down",	spr_controlsKey,	1))
.add(new input_key("gamepad",		binding_xbox.dpad_up,		gp_padu,		"Pad Up",		spr_controlsXbox,	14))
.add(new input_key("gamepad",		binding_xbox.dpad_down,		gp_padd,		"Pad Down",		spr_controlsXbox,	9))
.add(new input_key("gamepad",		binding_xbox.dpad_left,		gp_padl,		"Pad Left",		spr_controlsXbox,	11))
.add(new input_key("gamepad",		binding_xbox.dpad_right,	gp_padr,		"Pad Right",	spr_controlsXbox,	13))
.add(new input_key("gamepad",		binding_xbox.north,			gp_face4,		"North",		spr_controlsXbox,	3))
.add(new input_key("gamepad",		binding_xbox.east,			gp_face2,		"East",			spr_controlsXbox,	1))
.add(new input_key("gamepad",		binding_xbox.south,			gp_face1,		"South",		spr_controlsXbox,	0))
.add(new input_key("gamepad",		binding_xbox.west,			gp_face3,		"West",			spr_controlsXbox,	2))
.add(new input_key("gamepad",		binding_xbox.lb,			gp_shoulderl,	"Left Bumper",	spr_controlsXbox,	17))
.add(new input_key("gamepad",		binding_xbox.lt,			gp_shoulderlb,	"Left Trigger",	spr_controlsXbox,	18))
.add(new input_key("gamepad",		binding_xbox.rb,			gp_shoulderr,	"Right Bumper",	spr_controlsXbox,	20))
.add(new input_key("gamepad",		binding_xbox.rt,			gp_shoulderrb,	"Right Trigger",spr_controlsXbox,	21))
.add(new input_key("gamepad_axis",	binding_xbox.lstick_up,		gp_axislv_up,	"LStick Up",	spr_controlsXbox,	29))
.add(new input_key("gamepad_axis",	binding_xbox.lstick_down,	gp_axislv_down,	"LStick Down",	spr_controlsXbox,	24))
.add(new input_key("gamepad_axis",	binding_xbox.lstick_left,	gp_axislh_left,	"LStick Left",	spr_controlsXbox,	26))
.add(new input_key("gamepad_axis",	binding_xbox.lstick_right,	gp_axislh_right,"LStick Right",	spr_controlsXbox,	28))
.add(new input_key("gamepad",		binding_xbox.lstick_press,	gp_stickl,		"LStick Press",	spr_controlsXbox,	39))
.add(new input_key("gamepad_axis",	binding_xbox.rstick_up,		gp_axisrv_up,	"RStick Up",	spr_controlsXbox,	37))
.add(new input_key("gamepad_axis",	binding_xbox.rstick_down,	gp_axisrv_down,	"RStick Down",	spr_controlsXbox,	32))
.add(new input_key("gamepad_axis",	binding_xbox.rstick_left,	gp_axisrh_left,	"RStick Left",	spr_controlsXbox,	34))
.add(new input_key("gamepad_axis",	binding_xbox.rstick_right,	gp_axisrh_right,"RStick Right",	spr_controlsXbox,	36))
.add(new input_key("gamepad",		binding_xbox.rstick_press,	gp_stickr,		"RStick Press",	spr_controlsXbox,	40))
.add(new input_key("gamepad",		binding_xbox.start,			gp_start,		"Start",		spr_controlsXbox,	6));
#endregion

// Player input and controls
inputs = {
	left		: [binding_keyboard.a,				binding_xbox.dpad_left,		binding_xbox.lstick_left],
	right		: [binding_keyboard.d,				binding_xbox.dpad_right,	binding_xbox.lstick_right],
	up			: [binding_keyboard.w,				binding_xbox.dpad_up,		binding_xbox.lstick_up],
	down		: [binding_keyboard.s,				binding_xbox.dpad_down,		binding_xbox.lstick_down],
	
	interact	: [binding_keyboard.e,				binding_xbox.south],
	close		: [binding_keyboard.q,				binding_xbox.east],
	
	shoot		: [binding_keyboard.lmb,			binding_xbox.rt],
	grab		: [binding_keyboard.rmb,			binding_xbox.lt],
	reload		: [binding_keyboard.r,				binding_xbox.west],
	
	clickUI		: [binding_keyboard.lmb,			binding_xbox.rstick_press],
	
	swapWeapon	: [binding_keyboard.space,			binding_xbox.west],
	
	sprint		: [binding_keyboard.shift,			binding_xbox.lstick_press],
	
	swapUp		: [binding_keyboard.wheel_up,		binding_xbox.lb],
	swapDown	: [binding_keyboard.wheel_down,		binding_xbox.rb],
				
	pause		: [binding_keyboard.escape, 		binding_xbox.start],
}

controlListings = [];
//array_push(controlListings, [false,	"Shoot",				"shoot"]);
//array_push(controlListings, [false,	"Swap",					"swap"]);
//array_push(controlListings, [false,	"Jump",					"jump"]);
//array_push(controlListings, [false, "Grab Weapon",			"interact"]);
//array_push(controlListings, [false, "Consume Corpse",		"interact"]);
//array_push(controlListings, [false, "Activate Challenge",	"interact"]);
//array_push(controlListings, [false, "Use Vending Machine",	"interact"]);
//array_push(controlListings, [false, "Use Recycler",			"interact"]);
//array_push(controlListings, [false, "Use Slot Machine",		"interact"]);
//array_push(controlListings, [false, "Use Altar",			"interact"]);
//array_push(controlListings, [false, "Wait at Bus Stop",		"interact"]);

//// Using interactables																								
//array_push(controlListings, [false, "Previous Item",		"up"]);
//array_push(controlListings, [false, "Next Item",			"down"]);
//array_push(controlListings, [false, "Purchase",				"select"]);
//
//array_push(controlListings, [false, "Previous Weapon",		"up"]);
//array_push(controlListings, [false, "Next Weapon",			"down"]);
//array_push(controlListings, [false, "Sell",					"select"]);

//array_push(controlListings, [false, "Increase Bet",			"up"]);
//array_push(controlListings, [false, "Decrease Bet",			"down"]);
//array_push(controlListings, [false, "Roll Slots",			"select"]);

//array_push(controlListings, [false, "Previous Addiction",	"up"]);
//array_push(controlListings, [false, "Next Addiction",		"down"]);
//array_push(controlListings, [false, "Sacrifice",			"select"]);

//array_push(controlListings, [false, "Previous",				"up"]);
//array_push(controlListings, [false, "Next",					"down"]);
//array_push(controlListings, [false, "Select",				"select"]);
//array_push(controlListings, [false, "Close",				"close"]);
//
//array_push(controlListings, [false, "Previous Platter",		"left"]);
//array_push(controlListings, [false, "Next Platter",			"right"]);
//array_push(controlListings, [false, "Acquire Addiction",	"select"]);

// Number being displayed
numDisp = 0;
