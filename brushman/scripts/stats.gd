class_name Stats extends Resource

enum Faction{
	PLAYER,
	ENEMY,
}
signal health_changed(new_health: int, max_health: int)
signal death

@export var base_health:float 
@export var base_damage:float
@export var faction:Faction = Faction.PLAYER
@export var speed:float

var current_health: float: set = _on_health_set

func _init() -> void:
	initialize_stats.call_deferred()

func initialize_stats():
	current_health = base_health
	
func take_damage(amount: int):
	current_health -= amount

func _on_health_set(value: float):
	current_health = value
	if current_health <= 0:
		death.emit()
	health_changed.emit(current_health, base_health)
