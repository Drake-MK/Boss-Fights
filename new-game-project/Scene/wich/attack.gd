extends State

func enter():
	print('attack entred')
	super.enter()
	owner.set_physics_process(true)
	animation_player.play('attack')

func exit():
	print('attack exit')
	super.exit()
	owner.set_physics_process(false)
	print('run exit')


func _on_range_body_exited(body):
	pass # Replace with function body.
	if body.name == 'player':
		get_parent().change_state("run")
