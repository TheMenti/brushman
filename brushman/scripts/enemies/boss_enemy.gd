extends CharacterBody2D

@export var speed = 150.0
@export var turn_speed = 2.0  # How fast it turns towards player
var target_player = null

func _ready():
	target_player = get_tree().get_first_node_in_group("player")
	
	if position == Vector2.ZERO:
		reset_position_top()

func _physics_process(delta):
	if target_player:
		var target_dir = (target_player.global_position - global_position).normalized()
		velocity = velocity.lerp(target_dir * speed, turn_speed * delta)
		
		move_and_slide()

# 3. Handle Screen Exiting (Wrapping)
func _on_visible_on_screen_notifier_2d_screen_exited():
	wrap_screen()

func wrap_screen():
	var viewport_rect = get_viewport_rect()
	
	# Check which side we exited from
	if global_position.y > viewport_rect.size.y:
		# Exited BOTTOM -> Spawn at TOP
		global_position.y = -50 # Just above screen
		# Randomize X for variety, or keep same X
		global_position.x = randf_range(0, viewport_rect.size.x)
		
	elif global_position.x > viewport_rect.size.x:
		 # Exited RIGHT -> Spawn LEFT
		global_position.x = -50
		
	elif global_position.x < 0:
		# Exited LEFT -> Spawn RIGHT
		global_position.x = viewport_rect.size.x + 50
		
	# Reset velocity so it doesn't fly in sideways immediately
	velocity = Vector2.DOWN * speed 

func reset_position_top():
	var viewport_rect = get_viewport_rect()
	global_position.x = randf_range(0, viewport_rect.size.x)
	global_position.y = -100
	
