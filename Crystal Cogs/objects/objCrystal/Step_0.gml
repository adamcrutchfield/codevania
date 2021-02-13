/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

unpackIncomingLightPackets();
if (containerLightAmount(id) > 0 and numActiveLasers > 0) splitLight();
shootAllLightPackets();