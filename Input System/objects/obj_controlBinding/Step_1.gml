/// @desc Reset
for (var i = 0; i < array_length(controlListings); i++) {
	controlListings[i][0] = false;
}
numDisp = 0;

for(var i = 0; i < binding_xbox.length; i++) {
	if (masterKey.keyList[i] != 0) {
		masterKey.keyList[i].check_input();
	}
}

