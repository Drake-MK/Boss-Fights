extends Camera2D
@onready var camera_2d = $"."
@onready var striker = $".."


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	camera_2d.limit_left = 0
	camera_2d.limit_top = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
