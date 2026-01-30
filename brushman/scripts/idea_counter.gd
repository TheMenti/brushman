class_name IdeaCounter extends Node

@onready var level_ideas_label = $Label
var ideas_collected = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_ideas_counter():
	ideas_collected += 1
	level_ideas_label.set_deferred("text", str(ideas_collected))
	print(str(ideas_collected))
