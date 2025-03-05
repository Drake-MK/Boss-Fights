extends RayCast2D
@onready var dir = $"."
var pos
@onready var main = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if main.flip_h == false:
		dir.rotation = deg_to_rad(270)
		pos = 92
	else :
		dir.rotation = deg_to_rad(90)
		pos = -92


func _on_area_2d_area_entered(area):
	pass # Replace with function body.
