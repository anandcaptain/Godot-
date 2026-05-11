extends CanvasLayer

var score_label = null
var high_score_label = null
var game_over_panel = null
var game_over_label = null
var restart_button = null

func _ready():
	score_label = get_node("ScoreLabel")
	high_score_label = get_node("HighScoreLabel")
	game_over_panel = get_node("GameOverPanel")
	game_over_label = game_over_panel.get_node("GameOverLabel")
	restart_button = game_over_panel.get_node("RestartButton")
	
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
