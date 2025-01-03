class_name Dog extends Node2D

@export var sprites: Array[SpriteFrames]


@onready var lead_marker: Marker2D = %LeadMarker
@onready var sprite: AnimatedSprite2D = $AnimatedSprite
@onready var front_snow_particles: GPUParticles2D = $FrontSnowParticles
@onready var back_snow_particles: GPUParticles2D = $BackSnowParticles

var speed := 0.0

var height: float:
	set(value):
		if value != height:
			height = value
			sprite.position.y = height

func _ready() -> void:
	$AnimatedSprite.sprite_frames = sprites.pick_random()
	

func set_particles(value:bool)->void:
	front_snow_particles.emitting = value
	back_snow_particles.emitting = value
	
func on_speed_changed(new_speed:float):
	var prev_speed = speed
	speed = new_speed

	if height == 0:
		if speed==0 and prev_speed > 0 :
			#just stopped
			sprite.play("default")
			sprite.speed_scale=1.0			
		elif speed > 0 and prev_speed == 0:
			#just started
			sprite.play("run")
		if speed > 0:
			sprite.speed_scale=calculate_speed_scale()

func calculate_speed_scale():
	var ret = max(0.75, speed / Types.DEFAULT_SPEED)
	Logger.trace("factor: %2f" % ret)
	return ret
	
func on_jumped():
	sprite.speed_scale=1.0
	sprite.play("jump")
	set_particles(false)
	
	
func on_landed():
	sprite.speed_scale=1.0
	sprite.play("land")
	await sprite.animation_finished
	sprite.speed_scale=calculate_speed_scale()
	sprite.play("run")
	set_particles(true)


func _on_random_range_timer_timeout() -> void:
	$sfx_bark.play()
