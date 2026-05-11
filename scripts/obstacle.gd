extends Area3D

var player_ref = null
var hit = false

func _ready():
	player_ref = get_parent().get_parent().get_node("Player")

func _physics_process(delta):
	if player_ref == null:
		return
	
	# Delete if too far behind player
	if position.z < player_ref.position.z - 10:
		queue_free()
	
	# Check collision with player
	if not hit and is_instance_valid(player_ref):
		var player_box = player_ref.get_hit_box()
		var obstacle_box = AABB(position - Vector3(1.5, 1, 0.5), Vector3(3, 2, 1))
		
		if player_box.intersects(obstacle_box):
			hit = true
			player_ref.die()
			get_tree().root.get_node("Main").game_over()

func _on_area_entered(area):
	if area.name == "Player" and not hit:
		hit = true
		if is_instance_valid(player_ref):
			player_ref.die()
