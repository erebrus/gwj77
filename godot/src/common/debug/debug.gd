extends CanvasLayer

@export var debug_build: bool = true:
	set(value):
		debug_build = value
		visible = value

func _ready() -> void:
	%Version.text = ProjectSettings.get_setting("application/config/version")
	
