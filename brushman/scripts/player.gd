class_name player extends CharacterBody2D
@export var stats:Stats

@onready var SPEED := stats.speed

@onready var _animated_sprite = $player_animated_sprites
@onready var _Hitbox = $Hitbox/CollisionShape2D
@onready var _Hurtbox = $Hurtbox/CollisionShape2D
@onready var white_brush_area = $WhiteBrushArea
@onready var white_brush_shape = $WhiteBrushArea/CollisionShape2D

const JUMP_VELOCITY = -300.0
var is_unmasking = false
var is_attacking = false
var facing := 1 # 1 destra, -1 sinistra

var is_dead = false

func _ready():
	if stats:
		stats.death.connect(_on_death)
		stats.new_health.connect(_on_new_health)


func return_player_status():
	return is_dead

func play_anim(name: String) -> void:
	if _animated_sprite.animation != name:
		_animated_sprite.play(name)
		
func _physics_process(delta: float) -> void:
	# Gravità
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Salto
	if Input.is_action_just_pressed("jump") and is_on_floor():
		#$JumpSound.play()
		velocity.y = JUMP_VELOCITY
		if not is_attacking and not is_unmasking:
			play_anim("jumping")
		await get_tree().create_timer(0.1).timeout #leggero ritardo per suono
		play_anim("jumping")
	
	elif Input.is_action_pressed("jump") and not is_on_floor():
		velocity.y += delta * JUMP_VELOCITY - 3
		if velocity.y > 0 and not is_attacking and not is_unmasking:
			play_anim("falling")
		elif not is_on_floor() and not is_attacking and not is_unmasking:
			play_anim("jumping")

	# Movimento orizzontale
	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			$".".scale.x =  scale.y * -1
		else:
			$".".scale.x =  scale.y * 1
			
		if is_on_floor() and not is_attacking and not is_unmasking:
			play_anim("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and not is_attacking and not is_unmasking:
			play_anim("default")

	# Animazione in aria
	if not is_on_floor():
		if velocity.y > 0 and not is_attacking and not is_unmasking:
			play_anim("falling")
		elif not is_attacking and not is_unmasking:
			play_anim("jumping")
		
	move_and_slide()
	attack()
	reveal_platform()
	
func attack() -> void:
	if Input.is_action_just_pressed("brush_attack"):
		if not is_attacking and not is_unmasking:
			is_attacking = true
			play_anim("attack_brush")
			_Hitbox.set_deferred("disabled", false)
			await get_tree().create_timer(0.5).timeout
			_Hitbox.set_deferred("disabled", true)
			is_attacking = false
		

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.get_parent().stats.Faction.ENEMY:
		var damage_amount = area.get_parent().stats.base_damage
		stats.take_damage(damage_amount)
		_animated_sprite.modulate = Color(1.1, 0.0, 0.0, 1.0)
		_Hurtbox.set_deferred("disabled", true)
		await get_tree().create_timer(1).timeout
		_animated_sprite.modulate = Color(1.1, 1.1, 1.1, 1.0)
		_Hurtbox.set_deferred("disabled", false)
		

func reveal_platform() -> void:
	if Input.is_action_just_pressed("brush_unmask"):
		if not is_attacking and not is_unmasking:
			search_for_ghost_platform()


func search_for_ghost_platform():
	print("ricerca chiamata")
	is_unmasking = true
	play_anim("brush_unmask")
	white_brush_shape.set_deferred("disabled",false)
	await get_tree().create_timer(0.5).timeout
	white_brush_shape.set_deferred("disabled",true)
	is_unmasking = false
		

func _on_white_brush_area_area_entered(area: Area2D) -> void:
	print("Area individuata")
	var platform = area.get_parent()
	if platform.has_method("rivela_piattaforma"):
		platform.rivela_piattaforma()

func _on_death():
	is_dead = true
	var hud = get_parent().get_node("health_bar") #modifico il frame della salute
	hud.update_sprite(0) #frame con teschio
	
	var death_hud = get_parent().get_node("death_screen")
	death_hud.showDeathScreen()
	

func _on_new_health(amount: float):
	var hud = get_parent().get_node("health_bar") 
	if hud:
		hud.update_sprite(int(amount))

	
	
