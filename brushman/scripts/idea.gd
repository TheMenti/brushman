class_name Idea extends Area2D

@export var is_final_idea: bool = false
@export_file("*.tscn") var next_scene: String

@onready var animation = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var idea_sound = $AudioIdee

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
	if is_final_idea:
		if next_scene:
			get_tree().change_scene_to_file(next_scene)
		else:
			print("ERRORE: Hai dimenticato di impostare la next_scene nell'Inspector!")
	else:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if touched: return # Evita doppi trigger
	
	touched = true
	idea_sound.play()
	print("LOG - [picked idea]")
	
	get_tree().call_group("UI", "update_ideas_counter")
	
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	
	if not animation.animation_finished.is_connected(_on_destroy):
		animation.animation_finished.connect(_on_destroy)
