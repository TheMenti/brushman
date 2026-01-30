extends Node2D

@onready var pause_menu_hud = $new_pause_menu
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var player_status = player.return_player_status() 
		
		if(player_status):
			return
		pause_menu_hud.toggle_pause()
