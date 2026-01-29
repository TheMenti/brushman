extends Node2D
@onready var _Hurtbox = $Hurtbox/CollisionShape2D
@export var stats:Stats

func _on_area_entered(area: Area2D):
	queue_free()

	
	
