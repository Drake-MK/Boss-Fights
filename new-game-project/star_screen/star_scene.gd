extends Node2D

@onready var anim = $anim
var load  = preload("res://Scene/Main/field_1.tscn")
@onready var lab = $press_enter_to_sontinue/lab


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("movin_stars")
	lab.play("flicker")
func _process(delta):
	if Input.is_action_just_pressed('ui_accept'):
		get_tree().change_scene_to_packed(load)
