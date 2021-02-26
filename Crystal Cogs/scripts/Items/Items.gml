
#region item abstracts
function IItem() constructor {
	name = "";
	sprite = undefined;
	stackSize = 100;
}
function IColoredItem() : IItem() constructor {
	red = 255;
	green = 255;
	blue = 255;
}

#endregion

#region items
function ICrystalFragment() : IColoredItem() constructor {
	name = "Crystal Fragment";
	sprite = sprCrystalFragment;
}
function ICrystal() : IColoredItem() constructor {
	name = "Crystal";
	sprite = sprCrystal;
}
function IWood() : IItem() constructor {
	name = "Wood";
	sprite = sprWood;
}
function IStone() : IItem() constructor {
	name = "Stone";
	sprite = sprStone;
}
function IIron() : IItem() constructor {
	name = "Iron";
	sprite = sprIron;
}
function IGold() : IItem() constructor {
	name = "Gold";
	sprite = sprGold;
}
function IPlatinum() : IItem() constructor {
	name = "Platinum";
	sprite = sprPlatinum;
}
#endregion

#region golem parts
function IGolemPart() : IItem() constructor {
	stackSize = 1;
	material = undefined;
}
function ICrystalGolemPart() : IGolemPart() constructor {
	material = golemMaterials.crystal;
	red = 255;
	green = 255;
	blue = 255;
}

function IGolemTorso() : IGolemPart() constructor {
	name = "Golem Torso";
	sprite = sprGolemTorso;
}
function IGolemArm() : IGolemPart() constructor {
	name = "Golem Arm";
	sprite = sprGolemFrontarm;
}
function IGolemHead() : IGolemPart() constructor {
	name = "Golem Head";
	sprite = sprGolemHead;
}
function IGolemLegs() : IGolemPart() constructor {
	name = "Golem Legs";
	sprite = sprGolemFrontleg;
}

function ICrystalGolemTorso() : ICrystalGolemPart() constructor {
	name = "Crystal Golem Torso";
	sprite = sprGolemTorso;
}
function ICrystalGolemArm() : ICrystalGolemPart() constructor {
	name = "Crystal Golem Arm";
	sprite = sprGolemFrontarm;
}
function ICrystalGolemHead() : ICrystalGolemPart() constructor {
	name = "Crystal Golem Head";
	sprite = sprGolemHead;
}
function ICrystalGolemLegs() : ICrystalGolemPart() constructor {
	name = "Crystal Golem Legs";
	sprite = sprGolemFrontleg;
}
#endregion

#region initialize items
enum Item {
	crystalFragment,
	crystal,
	wood,
	stone,
	iron,
	gold,
	platinum,
	golemTorso,
	golemArm,
	golemHead,
	golemLegs,
	crystalGolemTorso,
	crystalGolemArm,
	crystalGolemHead,
	crystalGolemLegs
}

global.items = array_create(0);

global.items[Item.crystalFragment] = new ICrystalFragment();
global.items[Item.crystal] = new ICrystal();
global.items[Item.wood] = new IWood();
global.items[Item.stone] = new IStone();
global.items[Item.iron] = new IIron();
global.items[Item.gold] = new IGold();
global.items[Item.platinum] = new IPlatinum();

global.items[Item.golemTorso] = new IGolemTorso();
global.items[Item.golemArm] = new IGolemArm();
global.items[Item.golemHead] = new IGolemHead();
global.items[Item.golemLegs] = new IGolemLegs();
global.items[Item.crystalGolemTorso] = new ICrystalGolemTorso();
global.items[Item.crystalGolemArm] = new ICrystalGolemArm();
global.items[Item.crystalGolemHead] = new ICrystalGolemHead();
global.items[Item.crystalGolemLegs] = new ICrystalGolemLegs();
#endregion

#region item stack abstracts
function SItem(_count) constructor {
	count = _count;
	
	static dropItem = function(_x, _y) {
		with instance_create_layer(_x, _y, "Entities", objItem) {
			item = other;
			sprite_index = other.sprite;
		}
		return undefined;
	}
	
	static getItemRGB = function() {
		var _red = 255;
		var _green = 255;
		var _blue = 255;

		if variable_struct_exists(self, "red") _red = red;
		if variable_struct_exists(self, "green") _green = green;
		if variable_struct_exists(self, "blue") _blue = blue;

		return make_color_rgb(_red, _green, _blue);
	}
}
function SColoredItem(_red, _green, _blue, _count) : SItem(_count) constructor {
	red = _red;
	green = _green;
	blue = _blue;
}
#endregion

#region item stacks
function SCrystalFragment(_red, _green, _blue, _count) : SColoredItem(_red, _green, _blue, _count) constructor {
	name = global.items[Item.crystalFragment].name;
	sprite = global.items[Item.crystalFragment].sprite;
}
function SCrystal(_red, _green, _blue, _count) : SColoredItem(_red, _green, _blue, _count) constructor {
	name = global.items[Item.crystal].name;
	sprite = global.items[Item.crystal].sprite;
}
function SWood(_count) : SItem(_count) constructor {
	name = global.items[Item.wood].name;
	sprite = global.items[Item.wood].sprite;
}
function SStone(_count) : SItem(_count) constructor {
	name = global.items[Item.stone].name;
	sprite = global.items[Item.stone].sprite;
}
function SIron(_count) : SItem(_count) constructor {
	name = global.items[Item.iron].name;
	sprite = global.items[Item.iron].sprite;
}
function SGold(_count) : SItem(_count) constructor {
	name = global.items[Item.gold].name;
	sprite = global.items[Item.gold].sprite;
}
function SPlatinum(_count) : SItem(_count) constructor {
	name = global.items[Item.platinum].name;
	sprite = global.items[Item.platinum].sprite;
}
#endregion

#region golem part stacks
function SGolemPart(_shape, _material, _count) : SItem(_count) constructor {
	shape = _shape;
	material = _material;
}
function SCrystalGolemPart(_shape, _red, _green, _blue, _count) : SGolemPart(_shape, golemMaterials.crystal, _count) constructor {
	red = _red;
	green = _green;
	blue = _blue;
}

function SGolemTorso(_shape, _material, _count) : SGolemPart(_count) constructor {
	name = global.items[Item.golemTorso].name;
	sprite = global.items[Item.golemTorso].sprite;
}
function SGolemArm(_shape, _material, _count) : SGolemPart(_count) constructor {
	name = global.items[Item.golemArm].name;
	sprite = global.items[Item.golemArm].sprite;
}
function SGolemHead(_shape, _material, _count) : SGolemPart(_count) constructor {
	name = global.items[Item.golemHead].name;
	sprite = global.items[Item.golemHead].sprite;
}
function SGolemLegs(_shape, _material, _count) : SGolemPart(_count) constructor {
	name = global.items[Item.golemLegs].name;
	sprite = global.items[Item.golemLegs].sprite;
}

function SCrystalGolemTorso(_shape, _red, _green, _blue, _count) : SCrystalGolemPart(_shape, _red, _green, _blue, _count) constructor {
	name = global.items[Item.crystalGolemTorso].name;
	sprite = global.items[Item.crystalGolemTorso].sprite;
}
function SCrystalGolemArm(_shape, _red, _green, _blue, _count) : SCrystalGolemPart(_shape, _red, _green, _blue, _count) constructor {
	name = global.items[Item.crystalGolemArm].name;
	sprite = global.items[Item.crystalGolemArm].sprite;
}
function SCrystalGolemHead(_shape, _red, _green, _blue, _count) : SCrystalGolemPart(_shape, _red, _green, _blue, _count) constructor {
	name = global.items[Item.crystalGolemHead].name;
	sprite = global.items[Item.crystalGolemHead].sprite;
}
function SCrystalGolemLegs(_shape, _red, _green, _blue, _count) : SCrystalGolemPart(_shape, _red, _green, _blue, _count) constructor {
	name = global.items[Item.crystalGolemLegs].name;
	sprite = global.items[Item.crystalGolemLegs].sprite;
}
#endregion