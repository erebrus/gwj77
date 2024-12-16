extends Node2D

func enter(sled: Sled) -> void:
	Logger.info("Entered snow pile")
	sled.get_parent().modify_speed(0.5)
	

func exit(sled: Sled) -> void:
	Logger.info("Exited snow pile")
	sled.get_parent().modify_speed(1/0.5)
	
