extends StaticBody2D

var rivelata = false
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nascondi_piattaforma()
	pass # Replace with function body.
func nascondi_piattaforma():
	rivelata = false
	#semi-trasparenza
	sprite.modulate.a = 0.2
	#fisica rimossa se blocco non visibile
	collision.set_deferred("disabled",true)
	
func rivela_piattaforma():
	if rivelata: return
	
	rivelata = true
	#diventa visibile
	sprite.modulate.a = 1.0
	#attiva collisione
	collision.set_deferred("disabled",false)
	
	#introdurre suono
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
