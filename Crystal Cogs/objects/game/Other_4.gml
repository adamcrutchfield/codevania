/// @description determine whether to activate factory

if (room == rmTesting or room == rmHome) {
	instance_activate_object(factory);
} else {
	instance_deactivate_object(factory);
}