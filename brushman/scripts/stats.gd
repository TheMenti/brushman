class_name Stats extends Resource

enum Faction{
	PLAYER,
	ENEMY,
}
@export var base_health:float 
@export var base_damage:float
@export var faction:Faction = Faction.PLAYER
@export var speed:float
