/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

localizedName = "Crystal Growth Vat";

image_speed = 0;

waterMax = 100;

array_push(inventories, new MachineInventory(1, true, false));
array_push(inventories, new MachineInventory(1, false, true));
inputInv = inventories[0];
outputInv = inventories[1];
inputSlot = inputInv.items[| 0];
outputSlot = outputInv.items[| 0];

print("output slot: " + string(outputSlot))

hasCrystal = false;

crystalRed = 255;
crystalGreen = 255;
crystalBlue = 255;

ticksPerOperation = 30;
countdown = 0;
active = false;

growthComplete = 3;
crystalProgress = 0;

waterPerOperation = 10;