extends CharacterBody2D

@export var speed: float = 60.0
@export var damage_amount: int = 1
@export var gravity: float = 980.0

# 1 represents right, -1 represents left
var direction: int = 1 

@onready var ledge_check: RayCast2D = $LedgeCheck
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	ledge_check.position.x = 4  # Offset to look ahead (adjust based on sprite size)

func _physics_process(delta: float) -> void:
	# Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Check for walls or ledges to flip direction
	# is_on_wall() checks if the physics body hit a wall
	# !ledge_check.is_colliding() checks if the floor ran out
	if is_on_wall() or (is_on_floor() and not ledge_check.is_colliding()):
		flip_direction()
	
	# Apply Movement
	velocity.x = direction * speed
	move_and_slide()

func flip_direction() -> void:
	direction *= -1
	
	# Visual flip
	sprite.flip_h = (direction == -1)
	
	# Move the RayCast to the other side so it looks ahead of the new direction
	ledge_check.position.x = abs(ledge_check.position.x) * direction

# --- Damage Logic ---
# Connect the "body_entered" signal from your Area2D (Hitbox) to this function
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Assuming your player has a 'take_damage' function
		if body.has_method("take_damage"):
			body.take_damage(damage_amount)
