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
	area_entered.connect(_area_collided)
	
	if hitbox_liftime > 0.0:
		var mew_timer = Timer.new()  #inizializza nuovo timer
		add_child(new_timer)  #aggiunge child nodo timer
		new_timer.timeout.connect(queue_free)  #eliminazione del timer quando finito
		#new_timer.
	
	
#func _area_collided(area: Area2D) -> void 
	#pass
