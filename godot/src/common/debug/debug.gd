extends CanvasLayer

@export var debug_build: bool = true:
	set(value):
		debug_build = value
		visible = value

@export var avalanche_enabled: bool = false:
	get:
		return not debug_build or avalanche_enabled
	

func _ready() -> void:
	%Version.text = ProjectSettings.get_setting("application/config/version")
	
