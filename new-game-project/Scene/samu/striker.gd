extends CharacterBody2D
@onready var anim =  $AnimationPlayer
@onready var player = $"."
@onready var dash_dir = $main/RayCast2D
@onready var side_swing = $"side swing"


const SPEED = 150.0
const JUMP_VELOCITY = -220.0
const dash_velocity = 400

var dashing = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


	
func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 0.5

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		anim.play("jump")
		velocity.y = JUMP_VELOCITY
	
#    HANDEL RUNNING
	var direction = Input.get_axis("left", "right")
	if direction:
		if dashing :
			anim.play("dash")
			velocity.x = direction * dash_velocity
		else:
			anim.play("run")
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
	if direction > 0:
		$main.flip_h = false
	elif direction <0:
		$main.flip_h = true

	if not Input.is_anything_pressed():
		
		anim.play("idle")
	if Input.is_action_just_pressed("shoot") :
		anim.play(["l_atk", "r_atk"].pick_random())
		play_sword_sound()
		
		
		
	if Input.is_action_just_pressed("dash"):
		dashing = true
		$dash_timer.start(0.3)
	
	
	#print($main.position)
	move_and_slide()
	

		


func _on_dash_timer_timeout():
	pass # Replace with function body.
	dashing = false

func play_sword_sound():
	var random_pitch = randf_range(0.54, 1.4)  # Randomly pick a value
	side_swing.pitch_scale = random_pitch
	side_swing.play()

func lighton():
	$torch.visible = true
	
func lightoff():
	$torch.visible = false
