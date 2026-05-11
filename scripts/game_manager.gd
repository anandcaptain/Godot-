extends Node

var score = 0
var high_score = 0
var game_running = false
var player_ref = null
var camera_ref = null
var ui_ref = null

func _ready():
	load_high_score()
	start_game()

func _physics_process(delta):
	if game_running and is_instance_valid(player_ref):
		# Update camera to follow player
		if is_instance_valid(camera_ref):
			var target_pos = player_ref.position + Vector3(0, 4, 8)
			camera_ref.global_position = camera_ref.global_position.lerp(target_pos, 0.1)
			camera_ref.look_at(player_ref.position + Vector3(0, 1, 0), Vector3.UP)
		
		# Update score based on distance
		score = int(player_ref.position.z)
		if is_instance_valid(ui_ref):
			ui_ref.update_score(score, high_score)

func start_game():
	score = 0
	game_running = true
	
	# Create main game scene
	var subway_scene = preload("res://scenes/subway.tscn")
	var subway = subway_scene.instantiate()
	add_child(subway)
	
	player_ref = subway.get_node("Player")
	camera_ref = player_ref.get_node("Camera")
	ui_ref = get_node("../UI")

func add_score(points):
	if game_running:
		score += points
		if is_instance_valid(ui_ref):
			ui_ref.update_score(score, high_score)

func game_over():
	game_running = false
	
	if score > high_score:
		high_score = score
		save_high_score()
	
	if is_instance_valid(ui_ref):
		ui_ref.show_game_over(score, high_score)

func restart():
	get_tree().reload_current_scene()

func save_high_score():
	var config = ConfigFile.new()
	config.set_value("game", "high_score", high_score)
	config.save("user://subway_surfers.cfg")

func load_high_score():
	var config = ConfigFile.new()
	var error = config.load("user://subway_surfers.cfg")
	if error == OK:
		high_score = config.get_value("game", "high_score", 0)
