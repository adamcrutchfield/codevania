/// @description Insert description here
// You can write your code in this editor

//age for calcualting flating animation
age++;

//if touching an item this can stack with, combine
//ignores max stack sizes while in world
if (place_meeting(x, y, objItem)) {	
	var otherItem = instance_place(x, y, objItem);
	if (item.compareStack(otherItem.item)) {
		item.count += otherItem.item.count;
		instance_destroy(otherItem);
	}
}

//if near player, move towards them
if (distance_to_object(objSoul) <= 50) {
	hAcceleration = sign(objSoul.x-x) * 2;
	vAcceleration = sign(objSoul.y-y) * 2;
}

moveAndCollide();