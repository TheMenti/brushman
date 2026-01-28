class_name Stats extends Resource

enum faction{
	PLAYER,
	ENEMY,
}
@export var max_health:float = 100.0
@export var damage:float
signal health_reduced
signal death 

var health: int = 0: set = _on_health_set

func _init() -> void:
	initialize_resources.call_deferred()
	
func initialize_resources() -> void:
	health = max_health
	print(health)
	
func _on_health_set(new_value: int) -> void:
	health = new_value
	if health <= 0:
		death.emit()
		
