extends CharacterBody2D
@onready var _animated_sprite = $player_animated_sprites

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

func play_anim(name: String) -> void:
	if _animated_sprite.animation != name:
		_animated_sprite.play(name)
		
func falling_state(vel) -> bool:
		if vel < 0:
			return true
		else:
			return false

func _physics_process(delta: float) -> void:
	
	# Gravità
	if not is_on_floor():
		velocity += get_gravity() * delta
		if falling_state(velocity.y):
			play_anim("falling")
		
		

	# Salto
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		play_anim("jumping")
		if falling_state(velocity.y):
			play_anim("falling")
	
	if Input.is_action_pressed("jump") and not is_on_floor():
		velocity.y += delta * JUMP_VELOCITY - 3
		play_anim("jumping")
		if falling_state(velocity.y):
			play_anim("falling")

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
		play_anim("jumping")

	move_and_slide()

func attack():
	if Input.is_action_pressed("brush_attack"):
		pass
		
		
