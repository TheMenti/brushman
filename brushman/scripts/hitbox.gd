class_name Hitbox extends Area2D


var hitbox_lifetime: float
var hitbox_shape: Shape2D

func _init(_hitbox_lifetime: float, _hitbox_shape: Shape2D) -> void:
	hitbox_lifetime = hitbox_lifetime
	hitbox_shape = _hitbox_shape
	

func _ready() -> void:
	monitorable = false
	area_entered.connect(_on_area_entered)
	
	if hitbox_lifetime > 0.0:
		var new_timer = Timer.new()  #inizializza nuovo timer
		add_child(new_timer)  #aggiunge child nodo timer
		new_timer.timeout.connect(queue_free)  #eliminazione del timer quando finito
		new_timer.call_deferred("start", hitbox_lifetime)
	
	if hitbox_shape:
		var collision_shape = CollisionShape2D.new()
		collision_shape.shape = hitbox_shape
		add_child(collision_shape)
	
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
func _on_area_entered(area: Area2D) -> void:
	pass
