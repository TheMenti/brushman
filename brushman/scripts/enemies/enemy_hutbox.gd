extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scribble = get_node("../../Scribble")
	body_entered.connect(scribble._on_hitbox_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
