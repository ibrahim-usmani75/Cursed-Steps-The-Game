extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "hero1" and body.has_method("die"):
		print("You died in killzone!")
		body.die()
