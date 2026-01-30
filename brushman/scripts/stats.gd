class_name Stats extends Resource

enum Faction{
	PLAYER,
	ENEMY,
}

signal health_changed(new_health: int, max_health: int)
signal death
signal new_health(amount: float)

#TODO mettere segnale per danno per modificare HUD

@export var base_health:float 
@export var base_damage:float
@export var faction:Faction = Faction.PLAYER
@export var speed:float

var current_health:float

func _init() -> void:
	initialize_stats.call_deferred()

func initialize_stats():
	current_health = base_health

func take_damage(amount: float):
	current_health -= amount
	print(current_health)
	if current_health <= 0:
		current_health = base_health
		death.emit()
	else:
		new_health.emit(current_health)
