extends CanvasLayer

@onready var menu_holder = $Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_holder.visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
			toggle_pause()

func toggle_pause():
	var is_paused = get_tree().paused
	if is_paused:
		get_tree().paused = false
		menu_holder.visible = false
	else:
		get_tree().paused = true
		menu_holder.visible = true
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_resume_pressed() -> void:
	toggle_pause()


func _on_btn_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu_hud.tscn")
