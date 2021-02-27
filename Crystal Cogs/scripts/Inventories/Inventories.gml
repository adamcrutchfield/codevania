
function Inventory(_invSize) constructor {
	items = ds_list_create();
	size = _invSize;
	
	static addItem = function(_item) {
		
		var itemToAdd = _item;
		
		//first look through the inventory for any matching itemstack of less than max count
		for (var i = 0; i < size; i++) {
			var itemInSlot = items[| i];
			
			//if there's an item in the slot
			if (itemInSlot != undefined) {
				//if items are the same (except for count)
				if (itemToAdd.compareStack(itemInSlot)) {
					//add new stack to existing stack until full or count exhausted
					while (itemInSlot.count < itemInSlot.maxStackSize and itemToAdd.count > 0) {
						itemInSlot.count++;
						itemToAdd.count--;
					}
					if (itemToAdd.count == 0) break;
				}
			}
		}
		
		//next, look through inventory for an empty slot
		for (var i = 0; i < size; i++) {
			//if found, add the rest of itemToAdd to that slot
			if (itemInSlot == undefined) {
				ds_list_add(items, itemToAdd);
				//itemToAdd.count = 0;
				return;
			}
		}
		
		//if item failed to completely add
		if (itemToAdd.count > 0) itemToAdd.dropItem(room_width/2, room_height/2);
	}
	
	static dropInventory = function(_x, _y) {
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
