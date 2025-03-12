extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_death_fall_body_entered(body):
	pass # Replace with function body.
	if body.name == 'player':
		get_tree().reload_current_scene()
