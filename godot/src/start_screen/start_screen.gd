extends Control


func _ready() -> void:
	Globals.in_game=false
	if not Globals.music_manager.menu_music.playing:
		Globals.music_manager.fade_in_menu_music()


func _on_start_button_pressed() -> void:
	$sfx_button.play()
	%StartButton.disabled=true
	#if $sfx_button.stream:
		#await $sfx_button.finished
	var tween:= create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property($BlackFade,"modulate",Color(Color.WHITE),.5)
	await tween.finished
	Globals.start_game()
	
