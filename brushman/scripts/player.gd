extends CharacterBody2D
@onready var _animated_sprite = $player_animated_sprites

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

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
		# print("jump")
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
		
