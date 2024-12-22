extends Label


func _ready():
	hide()
	

func activate():
	visible=true
	$AnimationPlayer.play("default")
	
func deactivate():
	visible=false
	$AnimationPlayer.stop()
