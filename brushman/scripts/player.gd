extends CharacterBody2D

@onready var _animated_sprite = $player_animated_sprites
@onready var feedback_label = $FeedBackLabel

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

@onready var white_brush_area = $WhiteBrushArea
var max_dist_wb = 60.0


func _input(event):
	if event.is_action_pressed("brush_unmask"):
		svela_platform() 

			
func svela_platform():
	# Assicurati che white_brush_area sia definito in alto con @onready
	var blocchi_toccati = white_brush_area.get_overlapping_areas()
	
	for area in blocchi_toccati:
		var platform = area.get_parent()
		
		# ERRORE CORRETTO QUI SOTTO: avevi scritto "piattaforma" invece di "platform"
		var distance = global_position.distance_to(platform.global_position)
		
		# controllo distanza per usare pennello
		if distance > max_dist_wb:
			print("too far!")
			feedback_label.text = "Too Far!"
			feedback_label.visible = true
			await get_tree().create_timer(2.0).timeout
			feedback_label.visible = false
			continue
		
		if platform.has_method("rivela_piattaforma"):
			platform.rivela_piattaforma()

func _physics_process(delta: float) -> void:	
	if is_on_floor():
		_animated_sprite.play("default")

	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		_animated_sprite.play("jumping")
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("jump") and not is_on_floor():
		#print("jump")
		_animated_sprite.play("jumping")
		velocity.y += delta * JUMP_VELOCITY - 3
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func attack():
	if Input.is_action_pressed("brush_attack"):
		pass

#funzione che gestisce danno ricevuto 
func get_damage() -> void:
	#aggiungere valore dinamico del danno
	var hud = get_parent().get_node("health_bar")
	hud.update_sprite(3)

	
