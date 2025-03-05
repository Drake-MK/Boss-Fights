extends CharacterBody2D

@onready var ice = preload("res://Scene/Maze/ice.tscn")
@onready var ice_2 = preload("res://Scene/Maze/ice_2.tscn")
@onready var blue_maze = $"."
@onready var anim = $AnimationPlayer


@onready var bar = $"Health Bar/Bar"

var shoot = false

'''
var left = blue_maze.position - Vector2(10, 0)  # Move 10 units left
var right = blue_maze.position + Vector2(10, 0)  # Move 10 units right

'''
func _ready():
	anim.play("idle")
	shoot = false
	if bar:
		bar.health_zero.connect(_on_health_zero)

func _on_health_zero():
	print("Health is zero! Game over!")
	anim.play("dead")
func  _process(delta):pass
'''
	if shoot:
		var projectile = ice.instantiate()  # Creates a new projectile
		projectile.position = global_position  # Spawns at the shooter’s position
		projectile.direction = (get_global_mouse_position() - global_position).normalized()  # Aims towards mouse
		get_tree().current_scene.add_child(projectile)  # Adds projectile to scene
'''
func _on_detect_player_body_entered(body):
	
	if body.is_in_group('player'):
		phase_1()
func _on_detect_player_body_exited(body):
	pass # Replace with function body.
		

func oshoot():
	left_ice(0)
	right_ice(0)
func rshoot():
	var a = randf_range(-100,100)
	left_ice(a)
	right_ice(a)

	




func spawn_ice(target_position):
	var projectile = ice.instantiate()
	projectile.position = global_position  # Spawn at the boss's position
	projectile.target_position = target_position  # Send the target position
	get_tree().current_scene.add_child(projectile)	
	
func left_ice(a:int):
	var projectile = ice.instantiate()  # Creates a new projectile
	projectile.position = blue_maze.position - Vector2(100, a)
	projectile.direction = -1
	get_tree().current_scene.add_child(projectile)
func right_ice(a:int):
	var projectile = ice.instantiate()  # Creates a new projectile
	projectile.position = blue_maze.position + Vector2(100, a)
	projectile.direction = 1
	get_tree().current_scene.add_child(projectile)
func down_ice_2(a:int):
	var projectile_l = ice_2.instantiate()
	var projectile_r = ice_2.instantiate() 
	var x = blue_maze.position.x
	var y = blue_maze.position.y
	projectile_l.position = blue_maze.position - Vector2(0, y) + Vector2(-a, 100) 
	projectile_r.position = blue_maze.position - Vector2(0, y) + Vector2(a, 100)
	
	projectile_l.direction = 1
	projectile_r.direction = 1
	get_tree().current_scene.add_child(projectile_l)
	get_tree().current_scene.add_child(projectile_r)

func phase_1():
	var num = randi_range(3,5)
	var times = randi_range(2, 5)
	for i in range(0,times):
		for j in range(0,num):
			oshoot()		
			await get_tree().create_timer(0.1).timeout
		var t_break = randi_range(0.999999,3.9999999)
		await get_tree().create_timer(t_break).timeout
	await get_tree().create_timer(1).timeout
	phase_1_5()
func phase_1_5():
	var num = randi_range(3,5)
	var times = randi_range(2, 5)
	for i in range(0,times):
		for j in range(0,num):
			rshoot()		
			await get_tree().create_timer(0.1).timeout
		var t_break = randi_range(0.999999,3.9999999)
		await get_tree().create_timer(t_break).timeout
	phase_2()
func phase_2():
	var n = 100
	for i in range(1,4):
		down_ice_2(n)
		n+=200
	phase_1()
func _input(event):
	pass
