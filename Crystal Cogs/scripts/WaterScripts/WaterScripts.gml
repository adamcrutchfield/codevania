/// @ function	initWaterVars();
/// @ description initializes variables for processing water
function initWaterVars() {
	water = 0;										//
	waterMax = 0;									//
	maxWaterTransferRate = 1;						//
	//arrActiveDirections = array_create(4, true);	//
}

/// @ function	transferWater();
/// @ description transfer water to all adjacent machines that can recieve it
function transferWater() {
	
	//check for targets to send to
	var potentialMachines = array_create(0);
	if (position_meeting(x+GRID_SIZE, y, objMachine)) array_set(potentialMachines, array_length(potentialMachines), instance_position(x+GRID_SIZE, y, objMachine));	//east
	if (position_meeting(x, y-GRID_SIZE, objMachine)) array_set(potentialMachines, array_length(potentialMachines), instance_position(x, y-GRID_SIZE, objMachine));	//north
	if (position_meeting(x-GRID_SIZE, y, objMachine)) array_set(potentialMachines, array_length(potentialMachines), instance_position(x-GRID_SIZE, y, objMachine));	//west
	if (position_meeting(x, y+GRID_SIZE, objMachine)) array_set(potentialMachines, array_length(potentialMachines), instance_position(x, y+GRID_SIZE, objMachine));	//south
	
	//if has water to transfer and there are potential machines to send to
	if (array_length(potentialMachines) > 0) {
		
		//var mostCanTransfer = min(water, maxWaterTransferRate);
		var mostCanTransfer = min(water, maxWaterTransferRate)/* / array_length(potentialMachines)*/;
		var amountToTransfer = 0;
		
		for (var i = 0; i < array_length(potentialMachines); i++) {
			amountToTransfer = min(mostCanTransfer, potentialMachines[i].waterMax - potentialMachines[i].water);
			potentialMachines[i].water += amountToTransfer;
			water -= amountToTransfer;
			print(string(id) + " transferring " + string(amountToTransfer) + " water to " + string(potentialMachines[i]));
		}
	}
}