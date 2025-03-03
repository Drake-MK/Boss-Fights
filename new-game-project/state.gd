extends Node
class_name State

@onready var debug = owner.find_child("debug")
@onready var player = owner.get_parent().find_child("player")
@onready var animation_player = $"../.."


func _ready():
	set_physics_process(false)
	
func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)

func transtition():
	pass

func _physics_process(_delta):
	transtition()
	debug.text = name
	
