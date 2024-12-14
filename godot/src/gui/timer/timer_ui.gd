extends HBoxContainer

var start_millis: int
var started: bool = false

func start() -> void:
	start_millis = Time.get_ticks_msec()
	started = true
	_update()
	

func stop() -> void:
	started = false
	

func _process(_delta: float) -> void:
	if not started:
		return
	_update()
	

func _update() -> void:
	var time = Time.get_ticks_msec() - start_millis
	var minutes = time / 60_000
	var seconds = (time - minutes * 60_000) / 1_000.0
	$Minutes.text = "%02d" % minutes
	$Seconds.text = "%06.3f" % seconds
	
