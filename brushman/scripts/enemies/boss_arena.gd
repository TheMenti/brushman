extends Node2D

@onready var boss_camera = $BossCamera
@onready var arena_walls = $ArenaWalls/CollisionShape2D
@onready var boss_hud = $BossHealth
@onready var boss_enemy = $BossEnemy

func _ready():
	boss_hud.visible = false
	arena_walls.set_deferred("disabled", true) 
	boss_camera.enabled = true
	$TriggerZone.body_entered.connect(_on_trigger_zone_body_entered)

func _on_trigger_zone_body_entered(body):
	if body.is_in_group("Player"):
		start_boss_fight()

func start_boss_fight():
	boss_camera.make_current() 
	arena_walls.set_deferred("disabled", false)
	boss_hud.visible = true
	
	if boss_enemy.has_method("activate"):
		boss_enemy.activate()
	
	$TriggerZone.set_deferred("monitoring", false)
