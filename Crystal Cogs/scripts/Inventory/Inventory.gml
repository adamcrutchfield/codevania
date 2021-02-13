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

/// @ function			createItem(itemName, itemInfo);
/// @ param {string}	itemName
/// @ param {struct}	itemInfo
/// @ description creates an item
function createItem(itemName, itemInfo) {
	
	var item = {
		name : itemName,
		sprite : sprTinyGolem,
		count : 1
	}
	
	switch itemName {
		case "Raw Crystal":
			item.sprite = sprCrystal;
			variable_struct_set(item, "red", itemInfo.red);
			variable_struct_set(item, "green", itemInfo.green);
			variable_struct_set(item, "blue", itemInfo.blue);
			break;
		case "Machine":
			item.name = itemInfo.name;
			item.sprite = itemInfo.sprite;
		default:
			print("bad item created!");
			break;
	}
	
	return item;
}

/// @ description adds an item to an item inventory
function addItem(_inventory, _item) {
	for (var i = 0; i < array_length(_inventory.arrItems); i++) {
		
	}
}

function addItems(_inventory, _items) {
	
}

/// @ description spawns an item in the world
function dropItem(_item, _x, _y) {
	with instance_create_layer(_x, _y, "Entities", objItem) {
		item = _item;
		sprite_index = _item.sprite;
	}
}

/// @ description drop all items in an inventory
function dropInventory(_inventory) {
	for (var i = 0; i < array_length(_inventory.arrItems[i]); i++) {
			dropItem(_inventory.arrItems[i], x, y);
		}
}

/// @ description drop all inventories in given array
function dropInventories(_inventories) {
	for (var i = 0; i < array_length(_inventories); i++) {
		dropInventory(_inventories[i]);
	}
}

/// @ description drops a machine as an item
function dropMachineAsItem(_machine) {
	with (_machine) {
		
		//drop machine
		var itemInfo = {
			name : localizedName,
			sprite : sprite_index
		}
		dropItem(createItem("Machine", itemInfo), x, y);
		
		//drop items in machine's inventories
		dropInventories(inventories);
		
		//destroy machine
		instance_destroy();
	}
}