extends CanvasLayer

var score_label = null
var high_score_label = null
var game_over_panel = null
var game_over_label = null
var restart_button = null
var instruction_label = null

func _ready():
	score_label = get_node("ScoreLabel")
	high_score_label = get_node("HighScoreLabel")
	game_over_panel = get_node("GameOverPanel")
	game_over_label = game_over_panel.get_node("GameOverLabel")
	restart_button = game_over_panel.get_node("RestartButton")
	
	# Mobile detection
	var is_mobile = OS.get_name() in ["Android", "iOS"]
	
	# Add instruction label
	if not has_node("InstructionLabel"):
		instruction_label = Label.new()
		instruction_label.name = "InstructionLabel"
		instruction_label.anchor_left = 0.5
		instruction_label.anchor_top = 0.9
		instruction_label.anchor_right = 0.5
		instruction_label.anchor_bottom = 1.0
		instruction_label.offset_left = -100
		instruction_label.offset_top = -30
		instruction_label.text = "Swipe to move | Tap top to jump | Tap bottom to slide"
		instruction_label.add_theme_font_size_override("font_size", 16)
		add_child(instruction_label)
	
		if not is_mobile:
			instruction_label.text = "Arrow keys to move | Up to jump | Down to slide"
			instruction_label.add_theme_font_size_override("font_size", 14)
	
	if is_instance_valid(restart_button):
		restart_button.pressed.connect(_on_restart_pressed)

func update_score(score, high_score):
	if is_instance_valid(score_label):
		score_label.text = "Score: %d" % score
	
	if is_instance_valid(high_score_label):
		high_score_label.text = "High Score: %d" % high_score

func show_game_over(score, high_score):
	if is_instance_valid(game_over_panel):
		game_over_panel.visible = true
		game_over_label.text = "GAME OVER\nScore: %d\nHigh Score: %d" % [score, high_score]

func _on_restart_pressed():
	get_tree().root.get_node("Main").restart()
