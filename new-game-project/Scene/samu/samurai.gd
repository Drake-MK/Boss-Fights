extends CharacterBody2D
@onready var body = $"."

@onready var anim = $AnimationPlayer
@onready var player = $Sprite2D
@onready var sword = $sword

@export var SPEED = 300.0
@export var max_jump = 2

const JUMP_VELOCITY = -220.0
const dash_velocity = 400

var dashing = false
var jump_count =  0
var sword_count =  0
var input
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var current_state = state.MOVE
enum state {MOVE,SWORD,DEAD}

func _ready():
	dashing  = false
	sword_count = 0
	$sword/CollisionShape2D.disabled = true
	current_state = state.MOVE
	
func _physics_process(delta):
	match current_state:
		state.MOVE :
			moving(delta)
		state.SWORD:
			sword_attack(delta)
func moving(delta):
	input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if input != 0 :
		if is_on_floor():
			anim.play("run")
		if input > 0 :
			player.flip_h = false
			velocity.x += SPEED*delta
			velocity.x = clamp(SPEED,100,SPEED)
			sword.position.x = 18.385
		if input < 0 :
			player.flip_h = true
			
			velocity.x -= SPEED*delta
			velocity.x = clamp(-SPEED,100,-SPEED)
			sword.position.x = -18.385

			
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
		
	if Input.is_action_just_pressed("sword") && sword_count < 3:
		current_state = state.SWORD
	dashfnc()
	add_gravity(delta)
	move_and_slide()	

func add_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity *delta *3

func sword_attack(delta):

	anim.play("swing_1")
	input_movement(delta)

func input_movement(delta):
	input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if input != 0 :
		if input > 0 :
			velocity.x += SPEED*delta
			velocity.x = clamp(SPEED,100,SPEED)
			sword.position.x = 18.385
		if input < 0 :
			velocity.x -= SPEED*delta
			velocity.x = clamp(-SPEED,100,-SPEED)
			sword.position.x = -18.385
	if input == 0:
		velocity.x = 0
	add_gravity(delta)
	move_and_slide()

func dashfnc():
	if Input.is_action_just_pressed("dash"):
		dashing = true
func reset_state():
	current_state = state.MOVE

func _process(delta):
	if dashing:
		if player.flip_h:
			anim.play('dash')
			body.position.x -= 100
			dashing = false
		else : 
			anim.play('dash')
			body.position.x += 100
			dashing = false
