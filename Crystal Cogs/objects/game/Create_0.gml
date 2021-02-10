/// @description init vars

//set self offscreen
x = -32;
y = -32;

global.gridTargetX = round(mouse_x / 32) * 32;
global.gridTargetY = round(mouse_y / 32) * 32;

//custom mouse!
window_set_cursor(cr_none);
cursor_sprite = sprMouse;

global.secondsPassed = delta_time / 1000000;

instance_create_layer(x, y, "Lasers", laserDrawer);

arrMachinesGUI = array_create(0);
array_set(arrMachinesGUI, 0, objCrystal);
array_set(arrMachinesGUI, 1, objMirror);
array_set(arrMachinesGUI, 2, objRefractor);
array_set(arrMachinesGUI, 3, objFurnace);
array_set(arrMachinesGUI, 4, objWaterPump);
array_set(arrMachinesGUI, 5, objPipe);
array_set(arrMachinesGUI, 6, objTank);
print(array_length(arrMachinesGUI));

//immediately go to next room
room_goto_next();