/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

localizedName = "Crystal Growth Vat";

waterMax = 100;

array_push(inventories, createInventory(1, false));
crystalSlot = inventories[0];

crystalRed = 0;
crystalGreen = 0;
crystalBlue = 0;

ticksPerOperation = 30;
countdown = 0;

progress = 0;