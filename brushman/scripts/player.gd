class_name player extends CharacterBody2D
const attack_hitbox = preload("res://scripts/hitbox.gd")
@export var hitbox_shape: Shape2D
@onready var _animated_sprite = $player_animated_sprites
@export var stats:Stats

@onready var SPEED := stats.speed

@onready var feedback_label = $FeedBackLabel
@onready var white_brush_area = $WhiteBrushArea
var max_dist_wb = 60.0

const JUMP_VELOCITY = -300.0

func play_anim(name: String) -> void:
	if _animated_sprite.animation != name:
		_animated_sprite.play(name)

#variabile per bloccare gioco se player muore per gestione menu
var is_dead = false
func return_player_status():
	return is_dead

func svela_platform():
	var area_individuata = white_brush_area.get_overlapping_areas()
	get_damage(1)
	
	for area in area_individuata:
		var platform = area.get_parent()

		var distance = global_position.distance_to(platform.global_position)
		
		#controllo distanza per usare pennello 
		if distance > max_dist_wb:
			#print("too far")
			feedback_label.text = "Too Far!"
			feedback_label.visible = true
			
			await get_tree().create_timer(2.0).timeout
			feedback_label.visible = false
			continue
		
		if platform.has_method("rivela_piattaforma"):
			platform.rivela_piattaforma()



func _physics_process(delta: float) -> void:
	# Gravità
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		

	# Salto
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		play_anim("jumping")

	
	elif Input.is_action_pressed("jump") and not is_on_floor():
		velocity.y += delta * JUMP_VELOCITY - 3
		if velocity.y > 0:
			play_anim("falling")
		else:
			play_anim("jumping")

	# Movimento orizzontale
	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED
		_animated_sprite.flip_h = direction < 0
		if is_on_floor():
			play_anim("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			play_anim("default")

	# Animazione in aria
	if not is_on_floor():
		if velocity.y > 0:
			play_anim("falling")
		else:
			play_anim("jumping")
		
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("brush_attack") and not event.is_echo():
		var hitbox = Hitbox.new(stats, 0.5, hitbox_shape)
		add_child(hitbox)
	
	if event.is_action_pressed("brush_unmask"):
		print("attivato")
		svela_platform()

func get_damage(dmg) -> void:
	var hp = stats.base_health - dmg
	stats.base_health = hp
	var hud = get_parent().get_node("health_bar")
	hud.update_sprite(hp)
	
	if(stats.base_health <= 0):
		is_dead = true
		var death_hud = get_parent().get_node("death_screen")
		stats.base_health = stats.max_health
		death_hud.showDeathScreen()
	
