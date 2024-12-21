extends Control


func _ready() -> void:
	Globals.in_game=false



func _on_start_button_pressed() -> void:
	$sfx_button.play()
	Globals.start_game()
	
