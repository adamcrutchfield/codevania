/// @description init vars

global.secondsPassed = delta_time / 1000000;

//set self offscreen
x = -32;
y = -32;

//machine grid
global.gridTargetX = round(mouse_x / 32) * 32;
global.gridTargetY = round(mouse_y / 32) * 32;
global.machineGrid[1920/GRID_SIZE][1080/GRID_SIZE] = 0;


//custom mouse!
window_set_cursor(cr_none);
cursor_sprite = sprMouse;

//create laser drawer
instance_create_layer(x, y, "Lasers", laserDrawer);

//localized item names
global.localizedItemNames = array_create(NUM_ITEMS);
global.localizedItemNames[items.crystal] = "Crystal";
global.localizedItemNames[items.crystalFragment] = "Crystal Fragment";
global.localizedItemNames[items.machine] = "Machine";
global.localizedItemNames[items.wood] = "Wood";
global.localizedItemNames[items.stone] = "Stone";
global.localizedItemNames[items.iron] = "Iron";
global.localizedItemNames[items.gold] = "Gold";
global.localizedItemNames[items.platinum] = "Platinum";
global.localizedItemNames[items.golemTorso] = "Golem Torso";
global.localizedItemNames[items.golemArms] = "Golem Arms";
global.localizedItemNames[items.golemHead] = "Golem Head";
global.localizedItemNames[items.golemLegs] = "Golem Legs";

//temporary ui for spawning machines
arrMachinesGUI = array_create(0);
array_set(arrMachinesGUI, 0, objCrystal);
array_set(arrMachinesGUI, 1, objMirror);
array_set(arrMachinesGUI, 2, objRefractor);
array_set(arrMachinesGUI, 3, objFurnace);
array_set(arrMachinesGUI, 4, objWaterPump);
array_set(arrMachinesGUI, 5, objPipe);
array_set(arrMachinesGUI, 6, objVat);

//immediately go to next room
room_goto_next();