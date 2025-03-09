@onready var video_texture = $VideoStreamPlayer.get_texture()

func _process(delta):
    if video_texture:
        $TextureRect.modulate.a = 0.5  # Adjust transparency
