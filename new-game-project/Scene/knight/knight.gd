extends CharacterBody2D

@export var speed: float = 100.0
@export var attack_range: float = 30.0
@export var detection_range: float = 200.0
@export var attack_cooldown: float = 1.5

var player: Node2D = null
var can_attack: bool = true

func _ready():
	$AttackTimer.wait_time = attack_cooldown
	$AttackTimer.start()

func _physics_process(delta):
	if player and player.is_inside_tree():
		var distance = global_position.distance_to(player.global_position)
		
		if distance < attack_range and can_attack:
			attack()
		elif distance < detection_range:
			move_towards_player(delta)
	
func move_towards_player(delta):
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func attack():
	can_attack = false
	$AttackTimer.start()
	print("Samurai attacks!")  # Replace with actual attack animation and logic
	
func _on_AttackTimer_timeout():
	can_attack = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _on_Area2D_body_exited(body):
	if body == player:
		player = null
