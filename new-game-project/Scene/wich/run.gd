extends State
@onready var blue_witch = $"../.."

func enter():
	print('run enter')
	super.enter()
	owner.set_physics_process(true)
	animation_player.play('run')

func exit():
	super.exit()
	owner.set_physics_process(false)
	print('run exit')

func _on_range_body_entered(body):
	if body.name == 'player':
			print("attack mode")
			get_parent().change_state("attack")


func _on_p_layer_detect_body_exited(body):
	pass # Replace with function body.
	if body.name == 'player':
		get_parent().change_state("idle")
