class_name Hitbox extends Area2D

var damage: int 
var hitbox_liftime: float
var hitbox_shape: Shape2D

func _init(_damage: int, _hitbox_lifetime: float, _hitbox_shape: Shape2D) -> void:
	damage = _damage
	hitbox_liftime = hitbox_liftime
	hitbox_shape = _hitbox_shape
	

func _ready() -> void:
	monitorable = false
	area_entered.connect 
	
