extends PanelContainer


func _ready() -> void:
	hide()
	%Invulnerable.button_pressed = Debug.invulnerable
	 

func _input(event: InputEvent) -> void:
	if Debug.debug_build and event.is_action_pressed("debug"):
		visible = not visible
	

func _on_music_tension_toggle_pressed() -> void:
	if Globals.music_manager.current_game_music_id==Types.GameMusic.HARD:
		Globals.music_manager.change_game_music_to(Types.GameMusic.EASY)
	else:
		Globals.music_manager.change_game_music_to(Globals.music_manager.current_game_music_id+1)
	

func _on_next_level_pressed():
	#Events.level_up.emit()
	Globals.upgrade_manager.apply(Globals.upgrade_manager.get_random_available(1)[0])
	

func _on_win_game_pressed():
	Globals.do_win()
	


func _on_invulnerable_toggled(toggled_on: bool) -> void:
	Globals.player.invulnerable=toggled_on
	Debug.invulnerable = toggled_on
	Logger.info("No crashing = %s" % Globals.player.invulnerable)


func _on_enable_jump_pressed() -> void:
	Globals.player.jump_enabled=true


func _on_enable_turbo_pressed() -> void:
	Globals.player.turbo_factor=1.25
