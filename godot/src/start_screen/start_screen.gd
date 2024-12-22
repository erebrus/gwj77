extends Control


func _ready() -> void:
	Globals.in_game=false
	Globals.music_manager.fade_in_menu_music()


func _on_start_button_pressed() -> void:
	$sfx_button.play()
	Globals.start_game()
	
