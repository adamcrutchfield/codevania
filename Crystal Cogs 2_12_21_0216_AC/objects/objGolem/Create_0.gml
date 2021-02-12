/// @description init vars

event_inherited();

moveSpeed = 2;
grav = 0.9;
jumpTarget = GRID_SIZE * 4.2;

state = golemStates.empty;

//Drawing
//These variables will need to be given by whichever object creates the golem, afterwhich we'll remove them from here.
//These variables are used to determine which images to draw from each sprite and are dependent on which parts are chosen.
scale = 1;
partIndexHead = 1;
partIndexTorso = 1;
partIndexArms = 1;
partIndexLegs = 1;
