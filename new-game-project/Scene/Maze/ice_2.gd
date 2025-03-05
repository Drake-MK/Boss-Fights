extends Node

var player_position : Vector2
@onready var anim = $AnimationPlayer
@export var lifetime := 3.0

@onready var start = $start
@onready var run = $run
@onready var hit = $Hit
@onready var ice = $"."

@export var speed: float = 10  # Adjust speed as needed
var target_position: Vector2

var moving = false
var direction = 0
var move_towards : Vector2 = Vector2.ZERO
func _ready():
	
	
	start.visible = false
	run.visible = false
	hit.visible = false
	start_anim()

func start_anim():
	if direction == -1:
		$start.flip_h = true
	else : $start.flip_h = false
	start.visible = true
	run.visible = false
	hit.visible = false
	anim.play("start")
	moving = false
func run_anim():
	moving = true
	if direction == -1:
		$run.flip_h = true
	else : $run.flip_h = false
	start.visible = false
	run.visible = true
	hit.visible = false
	anim.play("move")
func hit_anim():
	moving = false
	if direction == -1:
		$Hit.flip_h = true
	else : $Hit.flip_h = false
	start.visible = false
	run.visible = false
	hit.visible = true
	moving = false
	anim.play("hit")

func _physics_process(delta):
	if moving:
		ice.position.y += 10
		

func _on_hitbox_body_entered(body):
	hit_anim()
