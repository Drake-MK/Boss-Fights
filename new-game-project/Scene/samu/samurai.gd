extends CharacterBody2D

@onready var anim = $AnimationPlayer
@onready var player = $Sprite2D

@export var SPEED = 300.0
@export var max_jump = 2

const JUMP_VELOCITY = -220.0
const dash_velocity = 400
var jump_count =  0
var input
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	moving(delta)
func moving(delta):
	input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if input != 0 :
		if is_on_floor():
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
		if is_on_floor():
			anim.play("idle")
		if !is_on_floor():
			anim.play("jump_1")
	if !is_on_floor():
		if jump_count < 1:
			anim.play("jump_1")
		if jump_count>1:
			anim.play("jump_2")
	if is_on_floor():
		jump_count = 0
	if Input.is_action_just_pressed("jump") && is_on_floor() && jump_count < 1 : 
		jump_count += 1
		velocity.y = JUMP_VELOCITY*4.5
	if Input.is_action_just_pressed("jump") && !is_on_floor() && jump_count < max_jump:
		jump_count += 1
		velocity.y = JUMP_VELOCITY*4
		
		
 
	add_gravity(delta)
	move_and_slide()	

func add_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity *delta *3
