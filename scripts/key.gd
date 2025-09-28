extends Sprite2D

var float_speed := 1.2    # how fast it bobs
var float_height := 4.0   # how far up/down it moves
var base_y := 0.0          # original Y position

func _ready():
	base_y = position.y

func _process(delta):
	position.y = base_y + sin(Time.get_ticks_msec() / 200.0 * float_speed) * float_height
