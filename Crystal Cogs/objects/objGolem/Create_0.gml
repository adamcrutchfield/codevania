/// @description init vars

state = golemStates.empty;

moveSpeed = 1.8;
jumpTarget = GRID_SIZE * 2.2;
grav = 0.7;
jumpBuffer = 0;

frictFloor = 0.65;

hAcceleration = 0;
vAcceleration = 0;

hSpeed = 0;
vSpeed = 0;

/*
//for tracking jump height
startJump = y;
jumpHeight = 0;
numTicks = 0;
*/