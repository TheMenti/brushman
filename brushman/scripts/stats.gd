class_name Stats extends Resource

enum faction{
	PLAYER,
	ENEMY,
}
@export var health:float 
@export var damage:float
signal health_reduced
signal death 
