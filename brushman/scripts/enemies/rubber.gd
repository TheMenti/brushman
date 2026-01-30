extends CharacterBody2D

@export var stats:Stats
const SPEED = 30.0
const JUMP_VELOCITY = -30.0
var direction:int
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_screen_exited)

func _on_screen_exited():
	queue_free()

func _on_area_2d_area_entered(area: Area2D):
	queue_free()

func _process(delta):
	# Move from right to left
	position.x -= SPEED * delta
	velocity.x -= -1 * SPEED


func _physics_process(delta: float) -> void:
	velocity.x = JUMP_VELOCITY
	move_and_slide()
	
