extends Node2D

func enter(sled: Sled) -> void:
	Logger.info("Entered snow pile")
	sled.get_parent().modify_current_speed(Types.PILE_SPEED_FACTOR)
	sled.get_parent().modify_acceleration(Types.PILE_ACCCEL_FACTOR)
	

func exit(sled: Sled) -> void:
	Logger.info("Exited snow pile")
	sled.get_parent().modify_acceleration(1/Types.PILE_ACCCEL_FACTOR)
	
