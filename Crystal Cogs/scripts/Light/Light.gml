/// @ function	initLightVars();
/// @ description initializes variables for processing light
function initLightVars() {
	arrLightProduce = array_create(NUM_COLORS, 0);	//amount produced of each color
	arrIncomingPackets = array_create(0);	//array of incoming light packets
	arrOutgoingPackets = array_create(0);	//array of outgoing light packets 
	arrLight = array_create(NUM_COLORS, 0);			//current amount of each color
	arrLasers = array_create(8, false);		//directions currently transmitting light
	numActiveLasers = 0;					//number of active lasers
	canTakeFromLightSource = false;			//whether machine can accept light from a light source
	lossCoefficient = 1;					//percent of light kept when repacking light
}

/// @ function					createLightPacket(_arrLight, _direction);
/// @ param {real}	_arrLight	array of light colors to store in packet
/// @ param {real}	_direction	direction to shoot the packet
/// @ param {real}	_laserColor	color of the laser to draw when sent
/// description create a light packet and add it to the array of outgoing packets
function createLightPacket(_arrLight, _direction) {
	//print(string(id) + " creating packet");
	
	//initialise the packet and set its direction
	var packet = {
		arrLight: array_create(NUM_COLORS, 0),
		packetDirection: _direction
	}
	
	//fill packet with light, multiplying by lossCoefficient
	for (var i = 0; i < NUM_COLORS; i++) packet.arrLight[i] = (_arrLight[i] * lossCoefficient);
	
	
	if (containerLightAmount(packet) > 0) {
		//add packet to outgoing
		array_set(arrOutgoingPackets, array_length(arrOutgoingPackets), packet);
	} else {	//refuse to create an empty packet
		print("can't make an empty packet!");
	}
}

/// @ function						shootLightPacket(_packetIndex);
/// @ param {real}	_packetIndex	index of arrOutgoingPackets to shoot
/// description shoot a packet of light in its direction
function shootLightPacket(_packetIndex) {
	var packetToShoot = arrOutgoingPackets[_packetIndex];
	
	//print(string(id) + " shooting packet containing " + string(packetToShoot));
	var x2 = x;
	var y2 = y;
	
	//find target for packet
	var targetOutsideRoom = (x2 < 0 or y2 < 0 or x2 > room_width or y2 > room_height);
	var machine = instance_position(x2, y2, objMachine);
	var loop = 0;
	do {
		if (packetToShoot.packetDirection < 180 and packetToShoot.packetDirection > 0) y2 -= GRID_SIZE;		//up
		if (packetToShoot.packetDirection > 180 or packetToShoot.packetDirection < 0) y2 += GRID_SIZE;		//down
		if (packetToShoot.packetDirection > 90 and packetToShoot.packetDirection < 270) x2 -= GRID_SIZE;	//left
		if (packetToShoot.packetDirection < 90 or packetToShoot.packetDirection > 270) x2 += GRID_SIZE;		//right
		
		targetOutsideRoom = (x2 < 0 or y2 < 0 or x2 > room_width or y2 > room_height);
		machine = instance_position(x2, y2, objMachine);
		loop++;
	} until (targetOutsideRoom or machine != noone or loop >= 100);
	
	//make target recieve packet
	if (machine != noone) with (machine) acceptLightPacket(packetToShoot);
	
	//set up laser to draw
	var laser = {
		arrLight: array_create(NUM_COLORS, 0),
		startX: x,
		startY: y,
		endX: x2,
		endY: y2
	}
	for (var i = 0; i < NUM_COLORS; i++) laser.arrLight[i] = packetToShoot.arrLight[i];
	array_set(laserDrawer.arrDrawLasers, array_length(laserDrawer.arrDrawLasers), laser);
}

/// @ function	shootAllLightPackets();
/// description shoot all outgoing packets in their directions
function shootAllLightPackets() {
	//print(string(id) + " shooting all packets");
	for (var i = 0; i < array_length(arrOutgoingPackets); i++) shootLightPacket(i);	//shoot all packets
	array_resize(arrOutgoingPackets, 0);	//clear outgoing packets array
}

/// @ function			acceptLightPacket(_acceptedPacket);
/// @ param {struct}	_acceptedPacket	light packet accepted
/// @ description adds packet to array of incoming packets
function acceptLightPacket(_acceptedPacket) {
	array_set(arrIncomingPackets, array_length(arrIncomingPackets), _acceptedPacket);
	//updateMachine(id);
}

/// @ function	unpackIncomingLightPackets();
/// @ description unpack all incoming light packets, adding their light to the machine's own and destroying the packets
function unpackIncomingLightPackets() {
	//print(string(id) + ": unpacking " + string(array_length(arrIncomingPackets)) + " incoming packets");
	
	//adds light from all packets to own light
	for (var i = 0; i < array_length(arrIncomingPackets); i++) {
		//print(string(id) + ": unpacking packet " + string(arrIncomingPackets[i]));
		for (var j = 0; j < NUM_COLORS; j++) {
			arrLight[j] += arrIncomingPackets[i].arrLight[j];
		}
	}
	//clears array of incoming packets
	array_resize(arrIncomingPackets, 0);
}

/// @ function	splitLight();
/// @ description splits stored light into evenly-sized packets, and directions based on active lasers
function splitLight() {
	if (numActiveLasers > 0) {									//if any lasers are active
		for (var i = 0; i < NUM_COLORS; i++) arrLight[i] /= numActiveLasers;	//divide stored light by the number of lasers
		for (var i = 0; i < 8; i++) {								//for each laser
			if (arrLasers[i]) {											//if this laser is active
				createLightPacket(arrLight, i * 45);						//create a light packet in the direction of the laser
			}
		}
		for (var i = 0; i < NUM_COLORS; i++) arrLight[i] = 0;				//clear stored light
	}	
}

/// @ function resetLight();
/// @ description resets currently stored light
function resetLight() {
	for (var i = 0; i < NUM_COLORS; i++) {
		arrLight[i] = arrLightProduce[i];	//reset to base light production
		if (canTakeFromLightSource and  position_meeting(x, y, objLightSource)) arrLight[i] += 3;	//if touching a light source, gain light
	}
}

/// @ function	reflectLight();
/// @ description reflects the direction of incoming light packets
function reflectLight() {
	for (var i = 0; i < array_length(arrIncomingPackets); i ++) {	//for each incoming packet
		createLightPacket(arrIncomingPackets[i].arrLight, calculateReflectionAngle(direction, arrIncomingPackets[i].packetDirection));
	}
	//clears array of incoming packets
	array_resize(arrIncomingPackets, 0);
}

/// @ function							refractLight(_refractDirection, _refractColor);
/// @ param	{real}		_refractColor	determines which color to refract from the others
/// @ param {boolean}	_isInverted		determines where new packets are sent
/// @ description of incoming light packets, reflects only the chosen color, allowing other light through
function refractLight(_refractColor, _isInverted) {
	for (var i = 0; i < array_length(arrIncomingPackets); i ++) {	//for each incoming packet
		if (containerHasColor(arrIncomingPackets[i], _refractColor)) {
			
			//create a packet with a new direction and only the chosen color, and a packet with the remaining colors and the same direction as before
			var arrSingleLight = array_create(NUM_COLORS, 0);
			var arrOtherLights = array_create(NUM_COLORS, 0);
			
			for (var j = 0; j < NUM_COLORS; j++) {
				if (j == _refractColor) {
					arrSingleLight[j] = arrIncomingPackets[i].arrLight[j];
				} else {
					arrOtherLights[j] = arrIncomingPackets[i].arrLight[j];
				}
			}
			if (!_isInverted) {
				createLightPacket(arrSingleLight, calculateReflectionAngle(direction, arrIncomingPackets[i].packetDirection));
				createLightPacket(arrOtherLights, arrIncomingPackets[i].packetDirection);
			} else {
				createLightPacket(arrSingleLight, arrIncomingPackets[i].packetDirection);
				createLightPacket(arrOtherLights, calculateReflectionAngle(direction, arrIncomingPackets[i].packetDirection));
			}
		} else {
			createLightPacket(arrIncomingPackets[i].arrLight, arrIncomingPackets[i].packetDirection);
		}
	}
	//clears array of incoming packets
	array_resize(arrIncomingPackets, 0);
}

// @ function								containerHasColor(_containerToCheck, _colorToCheck);
/// @ param	{struct}	_containerToCheck	light packet/machine to check
/// @ param	{real}		_colorToCheck		color to check for
/// @ description returns whether given container has more than 0 of a given color
function containerHasColor(_containerToCheck, _colorToCheck) {
	return (_containerToCheck.arrLight[_colorToCheck] > 0);
}

// @ function								containerHasSingleColor(_containerToCheck, _colorToCheck);
/// @ param	{struct}	_containerToCheck	light/machine packet to check
/// @ param	{real}		_colorToCheck		color to check for
/// @ description returns whether given container has more than 0 of a given color and 0 of all other colors
function containerHasSingleColor(_containerToCheck, _colorToCheck) {
	//print(string(id) + " checking packet for color " + string(_colorToCheck));
	
	for (var i = 0; i < NUM_COLORS; i++) {
		if (i != _colorToCheck and _containerToCheck.arrLight[i] > 0) return false;	//if there's any of any other color, return false
	}
	
	//if there's none of any other color, return whether there's any of the given color
	return (_containerToCheck.arrLight[_colorToCheck] > 0);
}

/// @ function							containerLightAmount(_containerToCheck);
/// @ param	{real}	_containerToCheck	light packet or machine to check
/// @ description returns total amount of light in container
function containerLightAmount(_containerToCheck) {
	var amount = 0;
	for (var i = 0; i < NUM_COLORS; i++) {
		amount += _containerToCheck.arrLight[i];
	}
	return amount;
}

/// @ function						calculateReflectionAngle(_mirrorAngle, _lightAngle);
/// @ param	{real}	_mirrorAngle	angle of mirror
/// @ param {real}	_lightAngle		direction of light
/// @ description calculates and returns a reflection direction based on mirror angle and light angle
function calculateReflectionAngle(_mirrorAngle, _lightAngle) {
	var relativeAngle = _mirrorAngle - _lightAngle;
	
	if (relativeAngle > 180) relativeAngle -= 180;
	if (relativeAngle < -180) relativeAngle += 180;
	
	var newAngle = _lightAngle;
	
	newAngle += (relativeAngle * 2) - 180;	
	if (newAngle >= 360) newAngle -= 360;
	if (newAngle < 0) newAngle += 360;
		
	return newAngle;
}

/// @ function						compareColors();
/// @ param {array}	_arrayToCheck	array of colors to check
/// @ param	{real}	_targetRed		target red percent
/// @ param	{real}	_targetGreen	target green percent
/// @ param	{real}	_targetBlue		target blue percent
/// @ description returns the percent similarity between the two colors
function compareColors(_arrayToCheck, _targetRed, _targetGreen, _targetBlue) {
	var brightestColorAmount = max(_arrayToCheck[lightColors.red], _arrayToCheck[lightColors.green], _arrayToCheck[lightColors.blue]);
	
	var redPercent = _arrayToCheck[lightColors.red] / brightestColorAmount;
	var greenPercent = _arrayToCheck[lightColors.green] / brightestColorAmount;
	var bluePercent = _arrayToCheck[lightColors.blue] / brightestColorAmount;
	
	var redSimilarity = 1 - abs(_targetRed - redPercent);	//if equal, returns 1. if nothing alike, returns 0
	var greenSimilarity = 1 - abs(_targetGreen - greenPercent);
	var blueSimilarity = 1 - abs(_targetBlue - bluePercent);
	
	var totalSimilarity = (redSimilarity + greenSimilarity + blueSimilarity) / 3;
	return totalSimilarity;
}

/// @ description returns the closest of 7 colors
function getClosestColor(_arrayToCheck) {
	
	var redPercent = compareColors(_arrayToCheck, 1, 0, 0);
	var closestColor = "red";
	var greenPercent = compareColors(_arrayToCheck, 0, 1, 0);
	if (greenPercent > redPercent) closestColor = "green";
	var bluePercent = compareColors(_arrayToCheck, 0, 0, 1);
	if (bluePercent > greenPercent) closestColor = "blue";
	
	var cyanPercent = compareColors(_arrayToCheck, 0, 1, 1);
	if (cyanPercent > bluePercent) closestColor = "cyan";
	var magentaPercent = compareColors(_arrayToCheck, 1, 0, 1);
	if (magentaPercent > cyanPercent) closestColor = "magenta";
	var yellowPercent = compareColors(_arrayToCheck, 1, 1, 0);
	if (yellowPercent > magentaPercent) closestColor = "yellow";
	
	var whitePercent = compareColors(_arrayToCheck, 1, 1, 1);
	if (whitePercent > yellowPercent) closestColor = "white";
	
	return closestColor;
}

/// @ function					drawLaser(_laser);
/// @ param {struct}	_laser	laser struct to draw
/// @ description draws a laser in a given direction until it hits something
function drawLaser(_laser) {
	//print("drawing laser");
	var x1 = _laser.startX;
	var y1 = _laser.startY;
	var x2 = _laser.endX;
	var y2 = _laser.endY;
	
	draw_set_color(getLaserColor(_laser));
	draw_set_alpha(getLaserAlpha(_laser));
	var width = getLaserWidth(_laser);
	
	draw_line_width(x1, y1, x2, y2, width);
	
	draw_set_color(c_white);
	draw_set_alpha(1);
}

/// @ function	drawLasers();
/// @ description draws multiple lasers 
function drawLasers() {
	//print("drawing lasers");
	for (var i = 0; i < array_length(arrDrawLasers); i++) drawLaser(arrDrawLasers[i]);
	array_resize(arrDrawLasers, 0);
}

/// @ function			getLaserColor(_laser);
/// @ param	{struct}	_laser
/// @ description get laser color
function getLaserColor(_laser) {
	var redAmount = _laser.arrLight[lightColors.red];
	var greenAmount = _laser.arrLight[lightColors.green];
	var blueAmount = _laser.arrLight[lightColors.blue];
	
	var brightestColorAmount = max(redAmount, greenAmount, blueAmount);
	var minBrightness = 255 / 4;
	
	var redBrightness = lerp(minBrightness, 255, redAmount / brightestColorAmount);
	var greenBrightness = lerp(minBrightness, 255, greenAmount / brightestColorAmount);
	var blueBrightness = lerp(minBrightness, 255, blueAmount / brightestColorAmount);
	
	return make_color_rgb(redBrightness, greenBrightness, blueBrightness);
}

/// @ function			getLaserAlpha(_laser);
/// @ param	{struct}	_laser
/// @ description get laser alpha
function getLaserAlpha(_laser) {
	
	//return 1;
		
	var brightnessCeiling = 10;
	
	var redAmount = _laser.arrLight[lightColors.red];
	var greenAmount = _laser.arrLight[lightColors.green];
	var blueAmount = _laser.arrLight[lightColors.blue];
	var totalAmount = redAmount + greenAmount + blueAmount;
	
	var alpha = min(totalAmount, brightnessCeiling) / brightnessCeiling;
	return alpha;
}

/// @ function			getLaserWidth(_laser);
/// @ param	{struct}	_laser
/// @ description get laser width
function getLaserWidth(_laser) {
	
	return 5;
	
	var minWidth = 1;
	var maxWidth = 10;
	
	var redAmount = _laser.arrLight[lightColors.red];
	var greenAmount = _laser.arrLight[lightColors.green];
	var blueAmount = _laser.arrLight[lightColors.blue];
	var avgAmount = (redAmount + greenAmount + blueAmount) / 3;
	
	var width = lerp(minWidth, maxWidth, min(avgAmount, maxWidth) / maxWidth);
	return width;
}

/// @ function		drawLightColor(_color);
/// @ param	{real}	_color
/// @ description returns a color based on input value
function drawLightColor(_color) {
	switch _color {
		case lightColors.red: return c_red;
		case lightColors.green: return c_lime;
		case lightColors.blue: return c_blue;
		default: return c_white;
	}
}