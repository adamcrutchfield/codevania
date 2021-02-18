/// @ function			createInventory(_invSize, _canAccept);
/// @ param	{real}		_invSize
/// @ param {boolean}	_canAccept
/// @ description creates an inventory, adding to a machine's array of inventories
function createInventory(_invSize, _canAccept, _canOutput) {
	var inv = {
		arrItems : array_create(_invSize, {}),
		canAccept : _canAccept,
		canOutput : _canOutput
	}
	return inv;
}

/// @ function			createItem(itemType, itemInfo, itemCount);
/// @ param {real}		itemType
/// @ param {struct}	itemInfo
/// @ param {real}		itemCount
/// @ description creates an item
function createItem(itemType, itemInfo, itemCount) {
	
	var item = {
		itemType : itemType,
		localizedName : "item",
		sprite : sprTinyGolem,
		count : itemCount
	}
	
	switch itemType {
		case items.crystal:
			item.sprite = sprCrystal;
			item.localizedName = "Crystal";
			setCrystalItemStats(item, itemInfo);
			break;
		case items.machine:
			item.localizedName = itemInfo.localizedName;
			item.sprite = itemInfo.sprite;
			break;
		case items.crystalFragment:
			item.sprite = sprCrystalFragment;
			break;
		case items.wood:
			item.sprite = sprWood;
			break;
		case items.stone:
			item.sprite = sprStone;
			break;
		case items.iron:
			item.sprite = sprIron;
			break;
		case items.gold:
			item.sprite = sprGold;
			break;
		case items.platinum:
			item.sprite = sprPlatinum;
			break;
		case items.golemTorso:
		case items.golemArms:
		case items.golemHead:
		case items.golemLegs:
			item.sprite = sprGolemHead;
			setGolemPartItemStats(item, itemInfo);
			break;
		default:
			print("bad item created!");
			break;
	}
	
	return item;
}

function setCrystalItemStats(item, itemInfo) {
	if !variable_struct_exists(itemInfo, "red") variable_struct_set(item, "red", 255);
	else variable_struct_set(item, "red", itemInfo.red);
	if !variable_struct_exists(itemInfo, "green") variable_struct_set(item, "green", 255);
	else variable_struct_set(item, "green", itemInfo.green);
	if !variable_struct_exists(itemInfo, "blue") variable_struct_set(item, "blue", 255);
	else variable_struct_set(item, "blue", itemInfo.blue);
}

function setGolemPartItemStats(item, itemInfo) {
	if !variable_struct_exists(itemInfo, "material") variable_struct_set(item, "material", golemMaterials.stone);
	else variable_struct_set(item, "material", itemInfo.material);
	
	if (item.material == golemMaterials.crystal) setCrystalItemStats(item, itemInfo);
}

/// @ description returns an inventory with an item added
function inventoryWithNewItem(_inventory, _item) {
	print("adding item " + string(_item) + " to inventory " + string(_inventory))
	for (var i = 0; i < array_length(_inventory.arrItems); i++) {
		if (slotIsClear(_inventory.arrItems[i])) {
			_inventory.arrItems[i] = _item;
			break;
		}
	}
	//returns new inventory
	print("new inventory: " + string(_inventory))
	return _inventory;
}

/// @ description spawns an item in the world
function dropItem(_item, _x, _y) {
	with instance_create_layer(_x, _y, "Entities", objItem) {
		item = _item;
		sprite_index = _item.sprite;
	}
}

/// @ description drop all items in an inventory
function dropInventory(_inventory, _x, _y) {
	for (var i = 0; i < array_length(_inventory); i++) {
		dropItem(_inventory.arrItems[i], _x, _y);
	}
}

/// @ description drop all inventories in given array
function dropInventories(_inventories, _x, _y) {
	for (var i = 0; i < array_length(_inventories); i++) {
		dropInventory(_inventories[i], _x, _y);
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
		dropItem(createItem("Machine", itemInfo, 1), x, y);
		
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

/// @ description returns an empty copy of the given inventory
function clearInventory(_inventory) {
	for (var i = 0; i < array_length(_inventory); i++) {
		_inventory.arrItems[i] = clearSlot();
	}
	return _inventory;
}

/// @ description returns an array of cleared inventories
function clearInventories(_inventories) {
	for (var i = 0; i < array_length(_inventories); i++) {
		_inventories[i] = clearInventory(_inventories[i]);
	}
	return _inventories;
}