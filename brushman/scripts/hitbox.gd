class_name Hitbox extends Area2D

var hitbox_liftime: float
var hitbox_shape: Shape2D

func _init(_hitbox_lifetime: float, _hitbox_shape: Shape2D) -> void:
	hitbox_liftime = hitbox_liftime
	hitbox_shape = _hitbox_shape
	

func _ready() -> void:
	monitorable = false
	area_entered.connect(_area_collided)
	
	if hitbox_liftime > 0.0:
		var new_timer = Timer.new()  #inizializza nuovo timer
		add_child(new_timer)  #aggiunge child nodo timer
		new_timer.timeout.connect(queue_free)  #eliminazione del timer quando finito
		new_timer.call_deferred("start", hitbox_liftime)
	
	if hitbox_shape:
		var collision_shape = CollisionShape2D.new()
		collision_shape.shape = hitbox_shape
		add_child(collision_shape)
	
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
func _area_collided(area: Area2D) -> void:
	pass
