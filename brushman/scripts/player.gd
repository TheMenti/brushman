class_name player extends CharacterBody2D
@onready var _animated_sprite = $player_animated_sprites
@export var stats:Stats
@onready var SPEED := stats.speed
@onready var _Hitbox = $Hitbox/CollisionShape2D
@onready var _Hurtbox = $Hurtbox/CollisionShape2D
const JUMP_VELOCITY = -300.0
var facing := 1 # 1 destra, -1 sinistra


func play_anim(name: String) -> void:
	if _animated_sprite.animation != name:
		_animated_sprite.play(name)
		
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
		if direction < 0:
			_animated_sprite.flip_h = true
			facing = -1
			_Hitbox.position.x = abs(_Hitbox.position.x) * facing
		else:
			_animated_sprite.flip_h = false
			facing = 1
			_Hitbox.position.x = abs(_Hitbox.position.x) * facing
			
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
	attack()
	
func attack() -> void:
	var timer = Timer.new()
	if Input.is_action_just_pressed("brush_attack"):
		_Hitbox.set_deferred("disabled", false)
		await get_tree().create_timer(0.5).timeout
		_Hitbox.set_deferred("disabled", true)
		
	

	





func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.get_parent().stats.Faction.ENEMY:
		var damage_amount = area.get_parent().stats.base_damage
		stats.take_damage(damage_amount)
		_Hurtbox.set_deferred("disabled", true)
		await get_tree().create_timer(1).timeout
		_Hurtbox.set_deferred("disabled", false)
		
