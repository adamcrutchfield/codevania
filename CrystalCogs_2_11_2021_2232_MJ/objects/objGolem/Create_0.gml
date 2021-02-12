/// @description init vars
//State Machine
state = golemStates.empty;

//Movement
moveSpeed = 1.8;
jumpTarget = GRID_SIZE * 2.2;
grav = 0.7;
jumpBuffer = 0;

frictFloor = 0.65;
frictAir = 1;

hAcceleration = 0;
vAcceleration = 0;

hSpeed = 0;
vSpeed = 0;

//Drawing
//These variables will need to be given by whichever object creates the golem, afterwhich we'll remove them from here.
//These variables are used to determine which images to draw from each sprite and are dependent on which parts are chosen.
scale = 1;
partIndexHead = 1;
partIndexTorso = 1;
partIndexArms = 1;
partIndexLegs = 1;

/*
//for tracking jump height
startJump = y;
jumpHeight = 0;
numTicks = 0;
*/