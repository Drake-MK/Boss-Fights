extends State

@onready var collision = $"../../Body"
@onready var progressbar = $"../../UI/ProgressBar/Label"

var player_entered: bool = false:
	set(value):
		player_entered = value
		collision.set_deferred("disabled",value)
		progressbar.set_deferred('visible',value)
		
func transition():
	if player_entered :
		get_parent().change_state("run")

func _on_p_layer_detect_body_entered(body):
	pass # Replace with function body.
	print(body)
	if body.name == 'player':
		player_entered = true
		print("hi")
		get_parent().change_state("run")
