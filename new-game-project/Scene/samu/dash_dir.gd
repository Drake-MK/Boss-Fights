extends RayCast2D
@onready var player = $".."
@onready var dash_area = $"."

func _process(delta):
	if player.Sprite2D.flip.h == true:
		dash_area.rotate(deg_to_rad(0))
	else : dash_area.rotate(deg_to_rad(180))
