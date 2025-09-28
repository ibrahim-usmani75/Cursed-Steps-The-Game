extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body):
	Global.has_key = true
	Global.key_obtained.emit()
	animation_player.play("sound")
	queue_free()
