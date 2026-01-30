extends CanvasLayer

@onready var menu_holder = $Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_holder.visible = false

func toggle_pause():
	var is_paused = get_tree().paused
	if is_paused:
		get_tree().paused = false
		menu_holder.visible = false
	else:
		get_tree().paused = true
		menu_holder.visible = true

func _on_resume_btn_pressed() -> void:
	toggle_pause()

func _on_try_again_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_b_tn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
