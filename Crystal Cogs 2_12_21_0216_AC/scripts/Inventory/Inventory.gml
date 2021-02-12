/// @ function			createInventory(_invSize, _canAccept);
/// @ param	{real}		_invSize
/// @ param {boolean}	_canAccept
/// @ description creates an inventory, adding to a machine's array of inventories
function createInventory(_invSize, _canAccept) {
	var inv = {
		arrItems : array_create(_invSize),
		canAccept : _canAccept
	}
	return inv;
}

/// @ description adds an item to an item inventory
function addItem(_inventory, _item) {
	for (var i = 0; i < array_length(_inventory.arrItems); i++) {
		
	}
}

function addItems(_inventory, _items) {
	
}

//spawns an item in the world
function dropItem(_item, _x, _y) {
	with instance_create_layer(_x, _y, "Entities", objItem) {
		variable_struct_set(itemStats, "item", _item.object_index);
		sprite_index = _item.sprite_index;
	}
}

//drops a machine as an item
function dropMachineAsItem(_machine) {
	
	dropItem(_machine, _machine.x, _machine.y);
	
	with (_machine) {
		for (var i = 0; i < array_length(inventories); i++) {
			for (var j = 0; j < array_length(inventories[i].arrItems[j]); j++) {
				dropItem(inventories[i].arrItems[j], x, y);
			}
		}
		
		instance_destroy();
	}
}