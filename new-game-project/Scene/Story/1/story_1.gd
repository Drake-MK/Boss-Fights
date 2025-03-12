extends Node2D

@onready var player = $player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.SPEED = player.SPEED*2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
