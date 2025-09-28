extends CharacterBody2D

@onready var ray_cast_r: RayCast2D = $RayCastR
@onready var ray_cast_l: RayCast2D = $RayCastL
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 50
var direction = 1
var attacking = false   # new state flag

func _process(delta: float) -> void:
	if attacking:
		# While attacking, just play attack animation and don’t move
		if animated_sprite_2d.animation != "attack":
			animated_sprite_2d.play("attack")
		return

	# Patrol movement
	if ray_cast_r.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_l.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false

	position.x += SPEED * direction * delta

	# Detect player (both rays)
	if ray_cast_r.is_colliding() and ray_cast_r.get_collider().is_in_group("Player"):
		start_attack()
	elif ray_cast_l.is_colliding() and ray_cast_l.get_collider().is_in_group("Player"):
		start_attack()

func start_attack():
	attacking = true
	animated_sprite_2d.play("attack")


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "attack":
		attacking = false
