extends Node2D
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_health(value: int):
	if value == 10:
		anim_sprite.play("full_health")
	if value == 9:
		anim_sprite.play("9_health")
	if value == 8:
		anim_sprite.play("8_health")
	if value == 7:
		anim_sprite.play("7_health")
	if value == 6:
		anim_sprite.play("6_health")
	if value == 5:
		anim_sprite.play("5_health")
	if value == 4:
		anim_sprite.play("4_health")
	if value == 3:
		anim_sprite.play("3_health")
	if value == 2:
		anim_sprite.play("2_health")
	if value == 1:
		anim_sprite.play("1_health")
	if value == 0:
		anim_sprite.play("0_health")
	
	


func _on_hero_1_health_changed() -> void:
	update_health($"..".value)
