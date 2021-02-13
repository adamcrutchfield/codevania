/// @description 

event_inherited();

active = (water > 10 and containerLightAmount(id) >= 9);

//when supplied with sufficient minerals and light, consume minerals and progress
if active {
	if (countdown <= 0) {
		countdown = ticksPerOperation;
	
		water -= 10;
		
		crystalRed += arrLight[lightColors.red];
		crystalGreen += arrLight[lightColors.green];
		crystalBlue += arrLight[lightColors.blue];
	
		//when crystal growth is complete
		if (progress >= 100) {
						
			var crystalColors = {
				red : crystalRed,
				green : crystalGreen,
				blue : crystalBlue
			}
			addItem(crystalSlot, createItem("Raw Crystal", crystalColors));
			
			crystalRed = 0;
			crystalGreen = 0;
			crystalBlue = 0;
			
			progress = 0;
		}
	
	} else countdown--;
	countdown = max(0, countdown);	
}

