/// @description Insert description here
// You can write your code in this editor

inventory = new Inventory(30);
mouseItem = {};

inventory.addItem(new SCrystal(255, 150, 0,  2));
inventory.addItem( new SWood(1));
inventory.addItem(new SIron(22));
inventory.addItem(new SWood(3));
inventory.addItem(new SGold(2));

mouseGridX = round(mouse_x / GRID_SIZE) * GRID_SIZE;
mouseGridY = round(mouse_y / GRID_SIZE) * GRID_SIZE;
//machineGrid[1920/GRID_SIZE][1080/GRID_SIZE] = 0;

//machine recipes


//temporary ui for spawning machines
arrMachinesGUI = array_create(0);
array_set(arrMachinesGUI, 0, objCrystal);
array_set(arrMachinesGUI, 1, objMirror);
array_set(arrMachinesGUI, 2, objRefractor);
array_set(arrMachinesGUI, 3, objFurnace);
array_set(arrMachinesGUI, 4, objWaterPump);
array_set(arrMachinesGUI, 5, objPipe);
array_set(arrMachinesGUI, 6, objVat);