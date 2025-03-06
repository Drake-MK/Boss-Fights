extends TextureProgressBar

signal health_zero
# Called when the node enters the scene tree for the first time.
@onready var bar = $"."

func _ready():
	bar.value = 67
	
func _on_hit_box_body_entered(body):
	if body.is_in_group("player_projectile"):
		bar.value-=10
func _on_hit_box_area_entered(area):
	if area.is_in_group("player_projectile"):
		bar.value-=10
		
func _process(delta):
	death()
	
func death():
	if bar.value <= 10:
		bar.queue_free()
		health_zero.emit()
		set_process(false)
