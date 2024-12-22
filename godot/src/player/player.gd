class_name Player extends Node2D

signal speed_changed(new_speed:float)

@export_category("dogs")
@export var DogPairScene: PackedScene
@export var dog_pair_number: int = 4
@export var sled_distance:= 10.0
@export var distance:= 20.0

@export_category("stats")
@export var turn_speed:= 60.0
@export var speed:= 150.0
@export var min_speed := 50.0
@export var accel:= 10.0
@export var breaking := 10.0
@export var turbo_factor := 1.0

@export_category("stamina")
@export var max_stamina := 100.0
@export var stamina_drain := 15.0
@export var stamina_recovery := 5.0
@export var stamina_depleted_timeout := 2.5
@export var stamina_speed_neutral := Vector2(.75,.9)
@export var stamina_jump_drain:= 20.0
var dog_pairs: Array[DogPair]
var is_alive:= false
var invulnerable := false
@onready var current_speed := min_speed
@onready var stamina := max_stamina:
	set(value):
		if value != stamina:
			stamina = value
			Events.stamina_changed.emit(stamina)

@onready var sled: Area2D = $Sled
@onready var stamina_timer: Timer = $StaminaTimer

var stamina_enabled := true
var jump_enabled:=false
var ui_avalanche_meter:=false:
	set(v):
		ui_avalanche_meter=v
		Events.ui_configuration_updated.emit()
var ui_speed_meter:=false:
	set(v):
		ui_speed_meter=v
		Events.ui_configuration_updated.emit()
var ui_stamina_meter:=false:
	set(v):
		ui_stamina_meter=v
		Events.ui_configuration_updated.emit()
var ui_distance_meter:=false:
	set(v):
		ui_distance_meter=v
		Events.ui_configuration_updated.emit()

func _ready() -> void:
	Globals.player = self
	
	_add_dog_pair(Vector2(sled_distance, 0))
	sled.follow_component.leader = dog_pairs[0]
	
	for i in range(1, dog_pair_number):
		_add_dog_pair(Vector2(sled_distance + i * distance, 0))
		dog_pairs[i-1].follow_component.leader = dog_pairs[i]
		
	speed_changed.emit(current_speed)
	stamina_timer.wait_time = stamina_depleted_timeout
	is_alive = true
	

func _physics_process(delta: float) -> void:
	
	sled.follow_component.at_distance(sled_distance)
	for i in dog_pair_number - 1:
		dog_pairs[i].follow_component.at_distance(distance)
		
	var turbo_on := false
	if is_alive:
		var previous_speed = current_speed
		var input = Input.get_vector("move_left", "move_right","break", "accelerate")		
		if input.y < 0:
			current_speed = max(min_speed, current_speed + delta * breaking * input.y)
			if Input.is_action_just_pressed("break") and not $sfx_break.playing:
				$sfx_break.play()
			
			_update_pitch()
			
		elif input.y > 0  and stamina > 0:
			turbo_on = turbo_factor > 1 and Input.is_action_pressed("turbo")
			if turbo_on and Input.is_action_just_pressed("turbo") and not $sfx_turbo.playing:
				$sfx_turbo.play()
				Logger.info("TURBO!")
			if not turbo_on and Input.is_action_just_pressed("accelerate") and not $sfx_accel.playing:
				$sfx_accel.play()
				
			var actual_max_speed = speed if not turbo_on else speed * turbo_factor
			var actual_accel = accel if not turbo_on else accel * turbo_factor
			current_speed = min(actual_max_speed, current_speed + delta * actual_accel * input.y)
			_update_pitch()
			if turbo_on:
				_drain_stamina(delta*stamina_drain)
		var velocity = Vector2(current_speed, input.x * turn_speed)
		dog_pairs.back().position += delta * velocity
		if current_speed != previous_speed:
			speed_changed.emit(current_speed)
		if jump_enabled and Input.is_action_just_pressed("jump"):
			dog_pairs.back().jump_component.jump()
			_drain_stamina(stamina_jump_drain)
	
	_recalibrate_positions()
	if not turbo_on:
		_recover_stamina(delta)
	

func _update_pitch():
	$sfx_layer2.pitch_scale=.85+.3*min((current_speed-75)/(225-75),1)


func _drain_stamina(drain_value: float):
	if not stamina_timer.is_stopped() or not stamina_enabled:
		return
	stamina-=drain_value
	if stamina <= 0:
		stamina = 0
		current_speed=min_speed
		Events.dogs_tired.emit()
		stamina_timer.start()
	
func _recover_stamina(delta: float):
	if not stamina_timer.is_stopped() or not stamina_enabled:
		return
	stamina += stamina_recovery*delta
	stamina = min(stamina, max_stamina)
	
func crash() -> void:
	if invulnerable:
		Logger.info("ignored crash.")
		return
	Events.obstacle_hit.emit()
	is_alive = false
	

func modify_current_speed(factor) -> void:
	current_speed *= factor


func modify_acceleration(factor:float) -> void:
	accel *= factor
	turn_speed *= factor


func _recalibrate_positions() -> void:
	var sled_offset = sled.position
	global_position = sled.global_position
	sled.position = Vector2.ZERO
	
	for i in dog_pair_number:
		dog_pairs[i].position -= sled_offset
	

func _add_dog_pair(at_position: Vector2) -> void:
	var dogs = DogPairScene.instantiate()
	dogs.position = at_position
	add_child(dogs)
	dog_pairs.append(dogs)
	speed_changed.connect(dogs.on_speed_changed)
	


func _on_stamina_timer_timeout() -> void:
	Events.stamina_exhaustion_finished.emit()
	$sfx_tired.play()
