extends Area3D

var collected = false
var rotation_speed = 5.0
var bob_amount = 0.3
var bob_speed = 2.0
var initial_y = 0.0

func _ready():
	initial_y = position.y

func _physics_process(delta):
	# Rotate coin
	rotate_y(rotation_speed * delta)
	
	# Bob up and down
	position.y = initial_y + sin(get_tree().get_frame() * bob_speed * 0.05) * bob_amount
	
	# Delete if too far behind
	if position.z < -100:
		queue_free()

func _on_area_entered(area):
	if not collected and area.name == "Player":
		collected = true
		get_tree().root.get_node("Main").add_score(10)
		queue_free()
