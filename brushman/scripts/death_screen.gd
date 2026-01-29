extends CanvasLayer

@onready var menuHolder = $Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menuHolder.visible = false

func showDeathScreen():
	get_tree().paused = true
	menuHolder.visible = true

func _on_try_again_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
