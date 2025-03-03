extends AnimatedSprite2D

@onready var player = get_parent().find_child('player')
@onready var sprite = $"."

var direction : Vector2	
var speed: float = 100.0	
func _ready():
	set_physics_process(true)

func _process(delta):
	direction = (player.position - position).normalized()
	
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _physics_process(delta):
	position += direction * speed * delta
