/// @description init vars

global.secondsPassed = delta_time / 1000000;

x = 0;
y = 0;


//custom mouse!
window_set_cursor(cr_none);
cursor_sprite = sprMouse;

//create other controllers
instance_create_layer(x, y, layer, factory);
instance_create_layer(x, y, "Lasers", laserDrawer);

//immediately go to next room
room_goto_next();