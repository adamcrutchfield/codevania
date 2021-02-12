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
	
}

function addItems(_inventory, _items) {
	
}