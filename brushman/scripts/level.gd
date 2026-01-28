extends Node

@export var level_scene: PackedScene
@export var speed = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_path_follower()
	$Path2D/PathFollow2D.progress += speed * delta

func spawn_path_follower():
	# 1. Create a NEW PathFollow2D for this specific enemy
	var new_follower = PathFollow2D.new()
	
	# 2. Instantiate the enemy visuals
	var enemy = level_scene.instantiate()
	
	# 3. Add the enemy as a CHILD of the follower
	# The enemy will now move wherever the follower moves
	new_follower.add_child(enemy)
	
	# 4. Add the follower to the Path2D
	$Path2D.add_child(new_follower) 


func auto_move_enemy():
	var enemy = level_scene.instantiate()
	# Choose a random location on Path2D.
	var enemy_spawn_location = $Path2D/PathFollow2D
	enemy_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	enemy.position = enemy_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = enemy_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(enemy)
