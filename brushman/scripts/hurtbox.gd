class_name Hurtbox extends Area2D
@onready var own_stats : Stats = owner.stats

func _ready() -> void:
	monitoring = false 
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	match own_stats.faction:
		Stats.Faction.PLAYER:
				set_collision_mask_value(1, true)
		Stats.Faction.ENEMY:
				set_collision_mask_value(2, true)

func recieve_hit(damage: float) -> void:
	own_stats.health -= damage 
