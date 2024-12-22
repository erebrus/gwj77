extends PanelContainer


@onready var distance_label: Label = %DistanceLabel
@onready var presents_label: Label = %PresentsLabel
@onready var score_label: Label = %ScoreLabel


func _ready() -> void:
	hide()
	
	

func open(distance: float, presents: float, score: float) -> void:
	distance_label.text = "%dm" % distance
	presents_label.text = "%d" % presents
	score_label.text = "%d" % score
	show()


func _on_try_again_button_pressed():
	Globals.start_game()


func _on_start_screen_button_pressed():
	Globals.start_screen()
	
