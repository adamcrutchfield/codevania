/// @description Insert description here
// You can write your code in this editor

draw_self();	//show collision box

//Collision Sprite
mask_index = sprGolem;
//Draw Golem
draw_sprite_ext(sprGolemBackfeet,partIndexLegs,x+(sign(scale)*15),y+sprite_height,scale,1,0,c_white,1);
draw_sprite_ext(sprGolemFrontfeet,partIndexLegs,x-(sign(scale)*12),y+sprite_height,scale,1,0,c_white,1);
draw_sprite_ext(sprGolemBackleg,partIndexLegs,x+(sign(scale)*12),y+56,scale,1,0,c_white,1);
draw_sprite_ext(sprGolemFrontleg,partIndexLegs,x-(sign(scale)*2),y+55,scale,1,0,c_white,1);
draw_sprite_ext(sprGolemBackhand,partIndexArms,x+(sign(scale)*25),y+38,scale,1,0,c_white,1);
draw_sprite_ext(sprGolemBackarm,partIndexArms,x+(sign(scale)*19),y+20,scale,1,0,c_white,1);
draw_sprite_ext(sprGolemTorso,partIndexTorso,x+(sign(scale)*4),y+50,scale,1,0,c_white,1);
draw_sprite_ext(sprGolemHead,partIndexHead,x+(sign(scale)*10),y+20,scale,1,0,c_white,1);
draw_sprite_ext(sprGolemFronthand,partIndexArms,x-(sign(scale)*21),y+42,scale,1,0,c_white,1);
draw_sprite_ext(sprGolemFrontarm,partIndexArms,x-(sign(scale)*6),y+20,scale,1,0,c_white,1);