extends Control


func _ready() -> void:
	Globals.in_game=false
	if not Globals.music_manager.menu_music.playing:
		Globals.music_manager.fade_in_menu_music()


func _on_start_button_pressed() -> void:
	$sfx_button.play()
	$StartButton.disabled=true
	if $sfx_button.stream:
		await $sfx_button.finished
	Globals.start_game()
	
