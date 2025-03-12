extends CharacterBody2D

@onready var anim = $anim
@onready var myself = $"."  # Reference to self
@onready var sprite = $AnimatedSprite2D
@onready var player = $"../player"  # Remove after testing
@onready var hurt_box = $hurt_box/CollisionShape2D

signal hit
var speed = 0.5

# Define states
enum State { IDLE, MOVING, ATTACKING }
var state = State.IDLE

func _ready():
	set_state(State.IDLE)
	hurt_box.disabled = true
	
func _process(delta):
	match state:
		State.IDLE:
			velocity.x = 0
			anim.play("idle")

		State.MOVING:
			anim.play("run")
			velocity.x = (player.position.x - myself.position.x) * speed
			sprite.flip_h = velocity.x < 0
			if sprite.flip_h: hurt_box.position.x = -40
			else : hurt_box.position.x = 56
			move_and_slide()

		State.ATTACKING:
			velocity.x = 0
			if sprite.flip_h : anim.play("attack_2")
			else : anim.play("attack_1")
			
func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _on_detect_body_entered(body):
	if body.name == "player" or body.name == "sumarai":
		set_state(State.MOVING)

func _on_detect_body_exited(body):
	if body.name == "player" or body.name == "sumarai":
		set_state(State.IDLE)


	

func _on_attack_player_body_entered(body):
	if body.name == "player" or body.name == "sumarai":
		set_state(State.ATTACKING)

func _on_attack_player_body_exited(body):
	if body.name == "player" or body.name == "sumarai":
		set_state(State.MOVING)

func set_state(new_state):
	state = new_state


func _on_hurt_box_body_entered(body):
	pass # Replace with function body.
	HitGlobal.enemy_died.emit()
