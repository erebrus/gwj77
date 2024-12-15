extends PanelContainer


func _ready() -> void:
	hide()
	%LandscapeButton.button_pressed = Globals.landscape
	

func _input(event: InputEvent) -> void:
	if Debug.debug_build and event.is_action_pressed("debug"):
		visible = not visible
	

func _on_music_tension_toggle_pressed() -> void:
	if Globals.music_manager.current_game_music_id==1:
		Globals.music_manager.change_game_music_to(2)
	else:
		Globals.music_manager.change_game_music_to(1)
	

func _on_next_level_pressed():
	Events.reached_level_end.emit()
	

func _on_win_game_pressed():
	Globals.do_win()
	

func _on_landscape_button_toggled(toggled_on):
	Globals.toggle_landscape(toggled_on)
	
