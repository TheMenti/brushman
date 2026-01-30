class_name Idea extends Area2D

@onready var animation = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
var touched = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if touched:
		animation.play("picked")
	else:
		animation.play("default")

func _on_destroy():
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	print("LOG - [picked idea]")
	touched = true
	get_tree().call_group("UI", "update_ideas_counter")
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	animation.animation_finished.connect(_on_destroy)
