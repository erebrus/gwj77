extends Node2D


func enter(_area: Area2D) -> void:
	if not $sfx.playing:
		$sfx.play()
	var previous_speed = Globals.player.current_speed
	var previous_acc = Globals.player.accel
	Globals.player.modify_current_speed(Types.PILE_SPEED_FACTOR)
	Globals.player.modify_acceleration(Types.PILE_ACCCEL_FACTOR)
	Logger.info("Entered snow pile. Speed: %.4f -> %.4f. Accel: %.4f -> %.4f" % [
		previous_speed, Globals.player.current_speed,
		previous_acc, Globals.player.accel
	])
	

func exit(_area: Area2D) -> void:
	var previous_speed = Globals.player.current_speed
	var previous_acc = Globals.player.accel
	Globals.player.modify_acceleration(1/Types.PILE_ACCCEL_FACTOR)
	Logger.info("Exited snow pile. Speed: %.4f -> %.4f. Accel: %.4f -> %.4f" % [
		previous_speed, Globals.player.current_speed,
		previous_acc, Globals.player.accel
	])
	
