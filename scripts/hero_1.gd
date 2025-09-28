extends CharacterBody2D

signal health_changed

@onready var camera_2d: Camera2D = $Camera2D
@onready var health_bar: Node2D = $HealthBar
@onready var timer: Timer = $Timer
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var value : int
var is_dead := false

const SPEED = 130.0
const JUMP_VELOCITY = -280.0

func _ready() -> void:
	value = 10

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_dead:
		velocity.y = JUMP_VELOCITY
		value -= 1

	# Handle movement input
	var direction := Input.get_axis("move_left", "move_right")
	if (Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")) and not is_dead:
		value -= 1
		anim_sprite.play("hurt")

	if direction > 0:
		anim_sprite.flip_h = false
	elif direction < 0:
		anim_sprite.flip_h = true

	# Handle animations if alive
	if not is_dead:
		if is_on_floor():
			if direction == 0 and value > 0:
				anim_sprite.play("idle")
			elif direction != 0 and value > 0:
				anim_sprite.play("walk")

	# Trigger death if health is gone
	if value <= 0 and not is_dead:
		die()

	# Movement
	if direction and not is_dead:
		velocity.x = direction * SPEED
	elif not is_dead:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	health_changed.emit()


func die() -> void:
	if is_dead:
		return
	is_dead = true
	Global.has_key = false

	anim_sprite.play("death")
	print("You Died!")

	# Slow motion
	Engine.time_scale = 0.3   # everything runs at 30% speed

	# Zoom camera in
	var tween := create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(2.0, 2.0), 2.0) # adjust zoom & duration as you like

	timer.start()   # triggers scene reload after delay


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
