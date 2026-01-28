extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -50.0

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_screen_exited)

func _on_screen_exited():
	queue_free()

func _on_body_entered(body):
	print("body_entered rubber")
	if body.is_class("Player") :
		queue_free()

func _process(delta):
	# Move from right to left
	position.x -= SPEED * delta
	velocity.x -= -1 * SPEED


func _physics_process(delta: float) -> void:
	velocity.x = JUMP_VELOCITY
	move_and_slide()
