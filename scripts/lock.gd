extends AnimatedSprite2D

func _ready():
	Global.key_obtained.connect(_on_key_obtained)

func _on_key_obtained():
	play("lock_unlocked")
