extends Node3D

var obstacle_scene = preload("res://scenes/obstacle.tscn")
var coin_scene = preload("res://scenes/coin.tscn")
var spawn_timer = 0.0
var spawn_interval = 1.5
var player_ref = null
var coins_spawned = 0
var max_coins = 50

func _ready():
	player_ref = get_parent().get_node("Player")

func _physics_process(delta):
	if player_ref == null or not player_ref.is_alive:
		return
	
	spawn_timer += delta
	
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_obstacle()
		
		# Randomly spawn coins
		if randf() > 0.6 and coins_spawned < max_coins:
			spawn_coin()

func spawn_obstacle():
	var obstacle = obstacle_scene.instantiate()
	var lane = randi() % 3 - 1  # -1, 0, 1
	var spawn_z = player_ref.position.z + 30
	
	obstacle.position = Vector3(lane * 3.0, 1, spawn_z)
	add_child(obstacle)

func spawn_coin():
	var coin = coin_scene.instantiate()
	var lane = randi() % 3 - 1
	var spawn_z = player_ref.position.z + 25
	
	coin.position = Vector3(lane * 3.0, 2, spawn_z)
	add_child(coin)
	coins_spawned += 1
