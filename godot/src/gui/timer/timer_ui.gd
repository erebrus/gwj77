extends HBoxContainer

var seconds: float = 0
var started: bool = false

func start() -> void:
	seconds = 0
	started = true
	_update()
	

func stop() -> void:
	started = false
	

func _process(delta: float) -> void:
	if not started:
		return
	seconds += delta
	_update()
	

func _update() -> void:
	var minutes = int(seconds / 60)
	var remainder = seconds - minutes * 60
	$Minutes.text = "%02d" % minutes
	$Seconds.text = "%06.3f" % remainder
	
