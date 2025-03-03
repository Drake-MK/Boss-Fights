extends CharacterBody2D

@onready var ice = preload("res://Scene/Maze/ice.tscn")
@onready var blue_maze = $"."


var shoot = false
'''
var left = blue_maze.position - Vector2(10, 0)  # Move 10 units left
var right = blue_maze.position + Vector2(10, 0)  # Move 10 units right

'''
func _ready():
	shoot = false
func  _process(delta):pass
'''
	if shoot:
		var projectile = ice.instantiate()  # Creates a new projectile
		projectile.position = global_position  # Spawns at the shooter’s position
		projectile.direction = (get_global_mouse_position() - global_position).normalized()  # Aims towards mouse
		get_tree().current_scene.add_child(projectile)  # Adds projectile to scene
'''
func _on_detect_player_body_entered(body):
	pass # Replace with function body.
	if body.name == 'player':
		phase_1()
		print("shoot = true")
		#shoot = true
		

func oshoot():
	left_ice()
	right_ice()
		
func spawn_ice(target_position):
	var projectile = ice.instantiate()
	projectile.position = global_position  # Spawn at the boss's position
	projectile.target_position = target_position  # Send the target position
	get_tree().current_scene.add_child(projectile)	
	
func left_ice():
	var projectile = ice.instantiate()  # Creates a new projectile
	projectile.position = blue_maze.position - Vector2(100, 0)
	projectile.direction = -1
	get_tree().current_scene.add_child(projectile)
func right_ice():
	var projectile = ice.instantiate()  # Creates a new projectile
	projectile.position = blue_maze.position + Vector2(100, 0)
	projectile.direction = 1
	get_tree().current_scene.add_child(projectile)
'''	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		spawn_ice(position)  # Fires projectile when mouse button is clicked
'''

func phase_1():
	var num = randi_range(5,10)
	var times = randi_range(4, 10)
	print(num,' ',times)
	for i in range(0,times):
		for j in range(0,num):
			oshoot()
			
			
			await get_tree().create_timer(0.1).timeout
		var t_break = randi_range(0.999999,3.9999999)
		await get_tree().create_timer(t_break).timeout
	
