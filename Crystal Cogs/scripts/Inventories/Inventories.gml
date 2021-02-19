
function Inventory(_invSize) constructor {
	items = ds_list_create();
	
	static addItem = function(_item) {
		ds_list_add(items, _item);
	}
	
	static dropInventory = function() {
		var listSize = ds_list_size(items);
		for (var i = 0; i < listSize; i++) {
			items[i].dropItem(_x, _y);
		}
	}
}

function MachineInventory(_invSize, _canAccept, _canOutput) : Inventory(_invSize) constructor {
	canAccept = _canAccept;
	canOutput = _canOutput;
}

/// @ description drop all inventories in given array
function dropInventories(_inventories, _x, _y) {
	for (var i = 0; i < array_length(_inventories); i++) {
		_inventories[i].dropInventory(_x, _y);
	}
}

/// @ description drops a machine as an item
function dropMachine(_machine) {
	with (_machine) {
		
		//drop machine's ingredients
		
		
		//drop items in machine's inventories
		dropInventories(inventories, x, y);
		
		//destroy machine
		instance_destroy();
	}
}

/// @ description returns whether an inventory slot is clear
function slotIsClear(slot) {
	return variable_struct_names_count(slot) == 0;
}
