extends Node2D

@onready var anim = $anim
var load_scene = preload("res://star_screen/star_scene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("fade_in")
	
func fade_out():
	anim.play("fade_out")
func load():
	get_tree().change_scene_to_packed(load_scene)
