extends CanvasLayer

@onready var health_bar_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar_sprite.pause()
	health_bar_sprite.frame = 2

func update_sprite(hp_player):
	health_bar_sprite.frame = hp_player
