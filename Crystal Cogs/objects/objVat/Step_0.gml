/// @description 

event_inherited();


active = (water >= waterPerOperation and containerLightAmount(id) >= 9 and slotIsClear(inventories[1].arrItems[0]));

if (!hasCrystal) {
	
}

//when supplied with sufficient minerals and light, consume minerals and progress
if active {
	if (countdown > 0) {
		countdown--;
	} else {
		countdown = ticksPerOperation;
		
		if (crystalProgress < growthComplete) {	//grow crystal
			crystalProgress++;
			
			water -= waterPerOperation;
			
			var brightestColorAmount = max(arrLight[lightColors.red], arrLight[lightColors.green], arrLight[lightColors.blue]);
	
			var redPercent = arrLight[lightColors.red] / brightestColorAmount;
			var greenPercent = arrLight[lightColors.green] / brightestColorAmount;
			var bluePercent = arrLight[lightColors.blue] / brightestColorAmount;
			
			crystalRed = lerp(crystalRed, redPercent*255, crystalProgress/growthComplete);
			crystalGreen = lerp(crystalGreen, greenPercent*255, crystalProgress/growthComplete);
			crystalBlue = lerp(crystalBlue, bluePercent*255, crystalProgress/growthComplete);
			
		} else {	//when crystal growth is complete, create crystal item
			crystalProgress = 0;
			
			var crystalColors = {
				red : crystalRed,
				green : crystalGreen,
				blue : crystalBlue
			}
			
			inventories[1] = inventoryWithNewItem(inventories[1], createItem(items.crystal, crystalColors, 1));
			dropItem(inventories[1].arrItems[0], x, y-GRID_SIZE);
			inventories[1].arrItems[0] = {};
			//dropItem(createItem(items.crystal, crystalColors, 1), x, y-GRID_SIZE);
			
			crystalRed = 0;
			crystalGreen = 0;
			crystalBlue = 0;
			
		}
	}
	countdown = max(0, countdown);	
}

