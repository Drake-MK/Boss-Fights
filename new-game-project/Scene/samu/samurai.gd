extends CharacterBody2D

@onready var anim = $AnimationPlayer
@onready var player = $Sprite2D

@export var SPEED = 300.0
const JUMP_VELOCITY = -220.0
const dash_velocity = 400

var input
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	moving(delta)
	
func moving(delta):
	input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if input != 0:
		anim.play("run")
		if input > 0 :
			player.flip_h = false
			velocity.x += SPEED*delta
			velocity.x = clamp(SPEED,100,SPEED)
		if input < 0 :
			player.flip_h = true
			velocity.x -= SPEED*delta
			velocity.x = clamp(-SPEED,100,-SPEED)
	if input == 0:
		velocity.x = 0
		anim.play("idle")
	
	add_gravity()
	move_and_slide()	

func add_gravity():
	velocity.y+=gravity
